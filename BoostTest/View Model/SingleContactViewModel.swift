//
//  SingleContactViewModel.swift
//  BoostTest
//
//  Created by Ayus Salleh on 15/02/2020.
//  Copyright © 2020 Ayus_Salleh. All rights reserved.
//

import UIKit

class SingleContactViewModel: BaseViewModel {

    enum InputType {
        case firstName
        case lastName
        case email
        case phone
    }
    
    private let helper = Helper()
    
    var contacts: [Contact] = []
    var editContact: Contact?
    var tableView: UITableView!
    var sectionTitle = ["Main Information", "Sub Information"]
    var rowTitle = [["First Name", "Last Name"], ["Email", "Phone"]]
    var rowHeight: CGFloat = 44

    var inputFirstName: (textField: UITextField, text: String) {
        let textField = getTextField(type: .firstName)
        return (textField, textField.text ?? "")
    }
    var inputLastName: (textField: UITextField, text: String) {
        let textField = getTextField(type: .lastName)
        return (textField, textField.text ?? "")
    }
    var inputEmail: (textField: UITextField, text: String?) {
        let textField = getTextField(type: .email)
        return (textField, textField.text ?? nil)
    }
    var inputPhone: (textField: UITextField, text: String?) {
        let textField = getTextField(type: .phone)
        return (textField, textField.text ?? nil)
    }
        
    /// This function used to get UITextField from SingleContactTableViewCell
    ///
    /// - Parameter editContactId: pass editContactId
    /// - Parameter completion: used for refresh UITableView
    func getData(editContactId: String?, completion: @escaping ()->()) {
        helper.getContactData { [weak self] (contacts, error) in
            if let error = error {
                self?.alertMessage = error.rawValue
            } else {
                self?.contacts = contacts
                self?.editContact = contacts.filter{ $0.id == editContactId }.first
                completion()
            }
        }
    }
    
    /// This function used to get UITextField from SingleContactTableViewCell
    ///
    /// - Parameter type: InputType of the TextField
    ///
    /// - Returns: UITextField
    func getTextField(type: InputType) -> UITextField {
        var indexPath = IndexPath(row: 0, section: 0)

        switch type {
        case .firstName:
            indexPath = IndexPath(row: 0, section: 0)
        case .lastName:
            indexPath = IndexPath(row: 1, section: 0)
        case .email:
            indexPath = IndexPath(row: 0, section: 1)
        case .phone:
            indexPath = IndexPath(row: 1, section: 1)
        }
        
        let cell = tableView.cellForRow(at: indexPath) as! SingleContactTableViewCell
        return cell.tfInput
    }
    
    /// This function used to get handle UITextField return key in Delegate
    ///
    /// - Parameter textField: Pass UITextField
    ///
    /// - Returns: UITextField
    func textFieldReturnKeyHandler(textField: UITextField) {
        textField.resignFirstResponder()
        
        if textField == inputFirstName.textField {
            inputLastName.textField.becomeFirstResponder()
        } else if textField == inputLastName.textField {
            inputEmail.textField.becomeFirstResponder()
        } else if textField == inputEmail.textField {
            inputPhone.textField.becomeFirstResponder()
        }
    }
    
    /// This function used to get cell detail/configuration
    ///
    /// - Parameter indexPath: Pass IndexPath of UITableView
    ///
    /// - Returns: Title, ReturnKeyType and Text
    func getCellDetail(indexPath: IndexPath) -> (title: String, returnKey: UIReturnKeyType, text: String?) {
        let section = indexPath.section
        let row = indexPath.row
        let title = rowTitle[section][row]
        let returnKey: UIReturnKeyType = (section == 1 && row == 1) ? .done : .next
        
        var text: String? = nil
        if let contact = editContact {
            let firstSectionText = row == 0 ? contact.firstName : contact.lastName
            let lastSectionText = row == 0 ? contact.email : contact.phone
            text = section == 0 ? firstSectionText : lastSectionText
        }
        
        return (title, returnKey, text)
    }
    
    /// This function used to save contact to local JSON file
    ///
    /// - Parameter completion: Can be used to handle UI after save successfully
    ///
    /// - Returns: Title, ReturnKeyType and Text
    func saveContact(completion: @escaping ()->()) {
        guard !inputFirstName.text.isEmpty, !inputLastName.text.isEmpty else {
            let errorMessage = inputFirstName.text.isEmpty ? "First Name is Required!" : "Last Name is Required!"
            self.alertMessage = errorMessage
            return
        }

        if let contact = editContact, let index = contacts.enumerated().filter({ $0.element.id == contact.id }).map({ $0.offset }).first {
            contacts[index].firstName = inputFirstName.text
            contacts[index].lastName = inputLastName.text
            contacts[index].email = inputEmail.text
            contacts[index].phone = inputPhone.text
        } else {
            let id = UUID().uuidString
            let contact = Contact(id: id, firstName: inputFirstName.text, lastName: inputLastName.text, email: inputEmail.text, phone: inputPhone.text)
            contacts.insert(contact, at: 0)
        }

        helper.updateContactData(contacts: contacts) { [weak self] (error) in
            if let error = error {
                self?.alertMessage = error.rawValue
            } else {
                completion()
            }
        }
    }
    
}

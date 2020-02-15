//
//  ContactsViewModel.swift
//  BoostTest
//
//  Created by Ayus Salleh on 15/02/2020.
//  Copyright © 2020 Ayus_Salleh. All rights reserved.
//

import UIKit

class ContactsViewModel: BaseViewModel {

    private let helper = Helper()
    
    var contacts: [Contact] = []
    
    func getContacts(completion: @escaping ()->()) {
        helper.getContactData { [weak self] (contacts, error) in
            if let error = error {
                self?.alertMessage = error.rawValue
            } else {
                self?.contacts = contacts
                completion()
            }
        }
    }
    
    func getCellTitle(indexPath: IndexPath) -> String {
        let contact = contacts[indexPath.row]
        return "\(contact.firstName) \(contact.lastName)"
    }
    
}

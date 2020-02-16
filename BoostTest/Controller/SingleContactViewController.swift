//
//  SingleContactViewController.swift
//  BoostTest
//
//  Created by Ayus Salleh on 15/02/2020.
//  Copyright © 2020 Ayus_Salleh. All rights reserved.
//

import UIKit

class SingleContactViewController: BaseViewController {

    @IBOutlet weak var barBtnCancel: UIBarButtonItem!
    @IBOutlet weak var barBtnSave: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = SingleContactViewModel()
    
    var editContactId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTableView()
    }
    
    @IBAction func barBtnCancelPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func barBtnSavePressed(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        
        viewModel.saveContact { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func configureUI() {
        configureViewModelBinding(viewModel)
        viewModel.tableView = tableView
        viewModel.getData(editContactId: editContactId) { [weak self] in
            self?.tableView.reloadData()
        }
        
        barBtnCancel.tintColor = themeColor
        barBtnSave.tintColor = themeColor
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SingleContactViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.rowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowTitle[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SingleContactTableViewCell", for: indexPath) as? SingleContactTableViewCell else {
            return UITableViewCell()
        }
        
        let (title, returnKey, text) = viewModel.getCellDetail(indexPath: indexPath)
        cell.setValue(title: title, returnKey: returnKey, text: text)
        cell.tfInput.delegate = self
        
        return cell
    }
}

extension SingleContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.textFieldReturnKeyHandler(textField: textField)
        return true
    }
}

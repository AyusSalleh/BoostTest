//
//  ViewController.swift
//  BoostTest
//
//  Created by Ayus Salleh on 15/02/2020.
//  Copyright © 2020 Ayus_Salleh. All rights reserved.
//

import UIKit

class ContactsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var barBtnAdd: UIBarButtonItem!
    
    private var viewModel = ContactsViewModel()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTableView()
        configureTarget()
    }
    
    @IBAction func barBtnAddPressed(_ sender: UIBarButtonItem) {
    }
    
    private func configureUI() {
        configureViewModelBinding(viewModel)
        configureData()
        
        title = "Contacts"
        barBtnAdd.tintColor = themeColor
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
    }
    
    private func configureTarget() {
        refreshControl.addTarget(self, action: #selector(refreshContacts(_:)), for: .valueChanged)
    }
    
    private func configureData() {
        viewModel.getContacts { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    @objc private func refreshContacts(_ sender: Any) {
        configureData()
    }

}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        
        cell.setValue(text: viewModel.getCellTitle(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contact = viewModel.contacts[indexPath.row]
    }
}


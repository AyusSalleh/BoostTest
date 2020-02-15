//
//  BaseViewController.swift
//  BoostTest
//
//  Created by Ayus Salleh on 15/02/2020.
//  Copyright © 2020 Ayus_Salleh. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureViewModelBinding(_ viewModel: BaseViewModel) {
        viewModel.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                if let message = viewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

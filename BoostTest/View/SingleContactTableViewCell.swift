//
//  SingleContactTableViewCell.swift
//  BoostTest
//
//  Created by Ayus Salleh on 15/02/2020.
//  Copyright © 2020 Ayus_Salleh. All rights reserved.
//

import UIKit

class SingleContactTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tfInput: UITextField!

    func setValue(title: String, returnKey: UIReturnKeyType, text: String?) {
        lblTitle.text = title
        tfInput.returnKeyType = returnKey
        tfInput.text = text
    }

}

//
//  ContactTableViewCell.swift
//  BoostTest
//
//  Created by Ayus Salleh on 15/02/2020.
//  Copyright © 2020 Ayus_Salleh. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewContact: ContactImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    func setValue(text: String) {
        lblTitle.text = text
    }

}

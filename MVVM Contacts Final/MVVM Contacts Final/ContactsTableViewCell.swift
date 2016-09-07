//
//  ContactsTableViewCell.swift
//  MVVM Contacts Final
//
//  Created by Rafael Sacchi on 9/5/16.
//  Copyright © 2016 Rafael Sacchi. All rights reserved.
//

import Foundation
import UIKit

class ContactsTableViewCell: UITableViewCell {
    var cellModel: ContactViewModel? {
        didSet {
            bindViewModel()
        }
    }

    func bindViewModel() {
        textLabel?.text = cellModel?.fullName
    }
}

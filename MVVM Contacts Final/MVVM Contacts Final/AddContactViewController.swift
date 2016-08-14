//
//  AddContactViewController.swift
//  MVVM Contacts Starter
//
//  Created by Rafael Sacchi on 8/13/16.
//  Copyright © 2016 Rafael Sacchi. All rights reserved.
//

import Foundation
import UIKit


class AddContactViewController: UIViewController {

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    let viewModel = AddContactViewModel()
    weak var delegate: AddContactViewModelDelegate? {
        didSet {
            viewModel.delegate = delegate
        }
    }

    @IBAction func didClickOnDoneButton(sender: UIBarButtonItem) {
        guard let firstName = firstNameTextField.text else {
            return
        }
        guard let lastName = lastNameTextField.text else {
            return
        }
        viewModel.addNewContact(firstName: firstName, lastName: lastName)
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func didClickOnCancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

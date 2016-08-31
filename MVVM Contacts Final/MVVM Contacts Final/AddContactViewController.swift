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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.becomeFirstResponder()
    }

    @IBAction func didClickOnDoneButton(sender: UIBarButtonItem) {
        guard let firstName = firstNameTextField.text else {
            return
        }
        guard let lastName = lastNameTextField.text else {
            return
        }
        if firstName.isEmpty || lastName.isEmpty {
            showEmptyNameAlert()
            return
        }
        dismissViewControllerAnimated(true) { [unowned self] in
            self.viewModel.addNewContact(firstName: firstName, lastName: lastName)
        }
    }

    @IBAction func didClickOnCancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    private func showEmptyNameAlert() {
        let alertView = UIAlertController(title: "Error",
                                          message: "A contact must have first and last names",
                                          preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .Destructive, handler: nil))
        presentViewController(alertView, animated: true, completion: nil)
    }

}

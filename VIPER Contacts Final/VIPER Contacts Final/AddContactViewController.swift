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
    let presenter = AddContactPresenter()
    weak var delegate: AddContactModuleDelegate? {
        didSet {
            presenter.delegate = delegate
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
        presenter.addNewContact(firstName: firstName, lastName: lastName)
    }

    @IBAction func didClickOnCancelButton(sender: UIBarButtonItem) {
        presenter.cancelAddContactAction()
    }

    private func showEmptyNameAlert() {
        let alertView = UIAlertController(title: "Error",
                                          message: "A contact must have first and last names",
                                          preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .Destructive, handler: nil))
        presentViewController(alertView, animated: true, completion: nil)
    }

}

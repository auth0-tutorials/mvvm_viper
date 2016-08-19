//
//  ContactsWireframe.swift
//  VIPER Contacts Starter
//
//  Created by Rafael Sacchi on 8/15/16.
//  Copyright © 2016 Rafael Sacchi. All rights reserved.
//

import Foundation
import UIKit

class ContactsWireframe {

    var contactsViewController: ContactsViewController?

    init(viewController: ContactsViewController) {
        contactsViewController = viewController
    }

    var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    }

    func showAddContactScreen() {
        let navController = mainStoryboard.instantiateViewControllerWithIdentifier("AddContactsNavigationController")
        if let addContactsVC = navController.childViewControllers.first as? AddContactViewController {
            addContactsVC.delegate = contactsViewController?.presenter
        }
        navController.modalPresentationStyle = .FullScreen
        navController.modalTransitionStyle = .CoverVertical
        contactsViewController?.presentViewController(navController, animated: true, completion: nil)
    }

}

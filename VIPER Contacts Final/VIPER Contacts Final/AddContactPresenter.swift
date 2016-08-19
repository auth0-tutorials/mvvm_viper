//
//  AddContactPresenter.swift
//  VIPER Contacts Starter
//
//  Created by Rafael Sacchi on 8/15/16.
//  Copyright © 2016 Rafael Sacchi. All rights reserved.
//

import Foundation
import UIKit

protocol AddContactModuleDelegate: class {
    func didAddContactAction()
    func didCancelAddContactAction()
}

class AddContactPresenter {
    weak var delegate: AddContactModuleDelegate?
    var interactor = AddContactInteractor()
    var wireframe: AddContactWireframe

    init(viewController: UIViewController) {
        wireframe = AddContactWireframe(presentedViewController: viewController)
    }

    func cancelAddContactAction() {
        wireframe.dismissAddContactInterface() { [weak delegate] in
            delegate?.didCancelAddContactAction()
        }
    }

    func addNewContact(firstName firstName: String, lastName: String) {
        interactor.saveNewContact(firstName: firstName, lastName: lastName)
        wireframe.dismissAddContactInterface() { [weak delegate] in
            delegate?.didAddContactAction()
        }
    }
}

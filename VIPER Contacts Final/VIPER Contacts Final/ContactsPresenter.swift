//
//  ContactsPresenter.swift
//  VIPER Contacts Starter
//
//  Created by Rafael Sacchi on 8/15/16.
//  Copyright © 2016 Rafael Sacchi. All rights reserved.
//

import Foundation
import UIKit

protocol ContactsInterface: class {
    func reloadInterface(with data: [DisplayContact])
}

class ContactsPresenter {

    let wireframe: ContactsWireframe
    let interactor = ContactsInteractor()
    weak var delegate: ContactsInterface?

    init(viewController: ContactsViewController) {
        wireframe = ContactsWireframe(viewController: viewController)
    }

    func retrieveContacts() {
        interactor.delegate = self
        interactor.retrieveContacts()
    }

    func addNewContact() {
        wireframe.showAddContactScreen()
    }
}

extension ContactsPresenter: ContactsInteractorOutput {

    func didRetrieveContacts(contacts: [Contact]) {
        delegate?.reloadInterface(with: contacts.map() {
            return DisplayContact(fullName: $0.fullName)
        })
    }

}

extension ContactsPresenter: AddContactModuleDelegate {
    func didAddContactAction() {
        print("did add")
    }

    func didCancelAddContactAction() {}
}

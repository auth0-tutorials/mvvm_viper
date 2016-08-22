//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation

class ContactListPresenter: ContactListPresenterProtocol {
    weak var view: ContactListViewProtocol?
    var interactor: ContactListInteractorInputProtocol?
    var wireFrame: ContactListWireFrameProtocol?

    func retrieveContacts() {
        interactor?.retrieveContacts()
    }

    func addNewContact(fromView view: ContactListView) {
        wireFrame?.presentAddContactScreen(fromView: view)
    }
}

extension ContactListPresenter: ContactListInteractorOutputProtocol {

    func didRetrieveContacts(contacts: [Contact]) {
        view?.reloadInterface(with: contacts.map() {
            return DisplayContact(fullName: $0.fullName)
        })
    }

}

extension ContactListPresenter: AddModuleDelegate {

    func didAddContact(contact: Contact) {
        view?.insert(contact: DisplayContact(fullName: contact.fullName), at: 0)
    }

    func didCancelAddContact() {}

}

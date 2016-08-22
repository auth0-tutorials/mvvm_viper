//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation

class VIPERPresenter: VIPERPresenterProtocol, VIPERInteractorOutputProtocol {
    weak var view: VIPERViewProtocol?
    var interactor: VIPERInteractorInputProtocol?
    var wireFrame: VIPERWireFrameProtocol?
    var delegate: AddModuleDelegate?

    func cancelAddContactAction() {
        if let view = view {
            wireFrame?.dismissAddContactInterface(from: view) { [weak delegate] in
                delegate?.didCancelAddContact()
            }
        }
    }

    func addNewContact(firstName firstName: String, lastName: String) {
        let contact = interactor?.saveNewContact(firstName: firstName, lastName: lastName)
        if let view = view, contact = contact {
            wireFrame?.dismissAddContactInterface(from: view) { [weak delegate] in
                delegate?.didAddContact(contact)
            }
        }
    }

}

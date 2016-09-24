//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//


class AddContactPresenter: AddContactPresenterProtocol, AddContactInteractorOutputProtocol {
    weak var view: AddContactViewProtocol?
    var interactor: AddContactInteractorInputProtocol?
    var wireFrame: AddContactWireFrameProtocol?
    var delegate: AddModuleDelegate?

    func cancelAddContactAction() {
        if let view = view {
            wireFrame?.dismissAddContactInterface(from: view) { [weak delegate] in
                delegate?.didCancelAddContact()
            }
        }
    }

    func addNewContact(firstName: String, lastName: String) {
        let contact = interactor?.saveNewContact(firstName: firstName, lastName: lastName)
        if let view = view, let contact = contact {
            wireFrame?.dismissAddContactInterface(from: view) { [weak delegate] in
                delegate?.didAddContact(contact)
            }
        }
    }

}

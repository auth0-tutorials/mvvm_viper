//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//


class AddContactInteractor: AddContactInteractorInputProtocol {
    weak var presenter: AddContactInteractorOutputProtocol?
    var APIDataManager: AddContactAPIDataManagerInputProtocol?
    var localDatamanager: AddContactLocalDataManagerInputProtocol?

    func saveNewContact(firstName: String, lastName: String) -> Contact? {
        do {
            let contact = try localDatamanager?.createContact(firstName: firstName, lastName: lastName)
            return contact
        } catch {
            return nil
        }
    }
}

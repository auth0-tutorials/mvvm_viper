//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation

class ContactListInteractor: ContactListInteractorInputProtocol {
    weak var presenter: ContactListInteractorOutputProtocol?
    var APIDataManager: ContactListAPIDataManagerInputProtocol?
    var localDatamanager: ContactListLocalDataManagerInputProtocol?

    func retrieveContacts() {
        do {
            if let contactList = try localDatamanager?.retrieveContactList() {
                presenter?.didRetrieveContacts(contactList)
            } else {
                presenter?.didRetrieveContacts([])
            }

        } catch {
            presenter?.didRetrieveContacts([])
        }
    }

}

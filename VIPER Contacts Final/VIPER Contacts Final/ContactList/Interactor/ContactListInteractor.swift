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
        let contacts = [Contact(firstName: "Alan", lastName: "Smith"),
                        Contact(firstName: "Beatrice", lastName: "Davies"),
                        Contact(firstName: "Chloe", lastName: "Brown"),
                        Contact(firstName: "Daniel", lastName: "Williams"),
                        Contact(firstName: "Edward", lastName: "Robinson"),
                        Contact(firstName: "Frankie", lastName: "Walker")]
        presenter?.didRetrieveContacts(contacts)
    }

}

//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation

class VIPERInteractor: VIPERInteractorInputProtocol {
    weak var presenter: VIPERInteractorOutputProtocol?
    var APIDataManager: VIPERAPIDataManagerInputProtocol?
    var localDatamanager: VIPERLocalDataManagerInputProtocol?

    func saveNewContact(firstName firstName: String, lastName: String) -> Contact {
        return Contact(firstName: firstName, lastName: lastName)
        // core data
    }
}

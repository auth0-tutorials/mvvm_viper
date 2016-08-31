//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation

class VIPERInteractor: VIPERInteractorInputProtocol {
    weak var presenter: VIPERInteractorOutputProtocol?
    var APIDataManager: VIPERAPIDataManagerInputProtocol?
    var localDatamanager: VIPERLocalDataManagerInputProtocol?

    func saveNewContact(firstName firstName: String, lastName: String) -> Contact? {
        do {
            let contact = try localDatamanager?.createContact(firstName: firstName, lastName: lastName)
            return contact
        } catch {
            return nil
        }
    }
}

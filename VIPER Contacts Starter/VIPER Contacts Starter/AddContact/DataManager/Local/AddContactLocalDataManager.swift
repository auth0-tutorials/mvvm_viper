//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import CoreData

enum PersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotCreateObject
    case objectNotFound
}

class AddContactLocalDataManager: AddContactLocalDataManagerInputProtocol {

    func createContact(firstName: String, lastName: String) throws -> Contact {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }

        if let newContact = NSEntityDescription.entity(forEntityName: "Contact",
                                                              in: managedOC) {
            let contact = Contact(entity: newContact, insertInto: managedOC)
            contact.firstName = firstName
            contact.lastName = lastName
            try managedOC.save()
            return contact
        }
        throw PersistenceError.couldNotCreateObject
    }

}

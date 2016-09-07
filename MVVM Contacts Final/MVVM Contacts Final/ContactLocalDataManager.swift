//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation
import CoreData

enum PersistenceError: ErrorType {
    case ManagedObjectContextNotFound
    case CouldNotCreateObject
    case ObjectNotFound
}

class ContactLocalDataManager {

    func createContact(firstName firstName: String, lastName: String) throws -> Contact {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.ManagedObjectContextNotFound
        }

        if let newContact = NSEntityDescription.entityForName(String(Contact),
                                                              inManagedObjectContext: managedOC) {
            let contact = Contact(entity: newContact, insertIntoManagedObjectContext: managedOC)
            contact.firstName = firstName
            contact.lastName = lastName
            try managedOC.save()
            return contact
        }
        throw PersistenceError.CouldNotCreateObject
    }

    func retrieveContactList() throws -> [Contact] {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.ManagedObjectContextNotFound
        }

        let request = NSFetchRequest(entityName: String(Contact))
        let caseInsensitiveSelector = #selector(NSString.caseInsensitiveCompare(_:))
        let sortDescriptorFirstName = NSSortDescriptor(key: "firstName", ascending: true, selector: caseInsensitiveSelector)
        let sortDescriptorLastName = NSSortDescriptor(key: "lastName", ascending: true, selector: caseInsensitiveSelector)
        request.sortDescriptors = [sortDescriptorFirstName, sortDescriptorLastName]

        if let contactList = try managedOC.executeFetchRequest(request) as? [Contact] {
            return contactList
        }
        throw PersistenceError.ObjectNotFound
    }

}

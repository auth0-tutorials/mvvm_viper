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

class ContactLocalDataManager {

    func createContact(firstName: String, lastName: String) throws -> Contact {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }

        if let newContact = NSEntityDescription.entity(forEntityName: String(describing: Contact.self),
                                                              in: managedOC) {
            let contact = Contact(entity: newContact, insertInto: managedOC)
            contact.firstName = firstName
            contact.lastName = lastName
            try managedOC.save()
            return contact
        }
        throw PersistenceError.couldNotCreateObject
    }

    func retrieveContactList() throws -> [Contact] {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }

        let request: NSFetchRequest<Contact> = NSFetchRequest(entityName: String(describing: Contact.self))
        let caseInsensitiveSelector = #selector(NSString.caseInsensitiveCompare(_:))
        let sortDescriptorFirstName = NSSortDescriptor(key: "firstName", ascending: true, selector: caseInsensitiveSelector)
        let sortDescriptorLastName = NSSortDescriptor(key: "lastName", ascending: true, selector: caseInsensitiveSelector)
        request.sortDescriptors = [sortDescriptorFirstName, sortDescriptorLastName]

        return try managedOC.fetch(request)
    }

}

import Foundation
import CoreData

enum PersistenceError: ErrorType {
    case ManagedObjectContextNotFound
    case CouldNotCreateObject
    case ObjectNotFound
}

class AddContactLocalDataManager: AddContactLocalDataManagerInputProtocol {

    func createContact(firstName firstName: String, lastName: String) throws -> Contact {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.ManagedObjectContextNotFound
        }

        if let newContact = NSEntityDescription.entityForName("Contact",
                                                              inManagedObjectContext: managedOC) {
            let contact = Contact(entity: newContact, insertIntoManagedObjectContext: managedOC)
            contact.firstName = firstName
            contact.lastName = lastName
            try managedOC.save()
            return contact
        }
        throw PersistenceError.CouldNotCreateObject
    }

}

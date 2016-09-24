import CoreData

class ContactListLocalDataManager: ContactListLocalDataManagerInputProtocol {

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

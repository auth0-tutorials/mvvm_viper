//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation
import CoreData

class ContactListLocalDataManager {

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

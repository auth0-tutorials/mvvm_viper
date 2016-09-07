//
//  Contact+CoreDataProperties.swift
//  VIPER Contacts Final
//
//  Created by Rafael Sacchi on 8/30/16.
//  Copyright © 2016 Rafael Sacchi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Contact {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?

}

//
//  Contact.swift
//  MVVM Contacts Starter
//
//  Created by Rafael Sacchi on 8/13/16.
//  Copyright © 2016 Rafael Sacchi. All rights reserved.
//

import Foundation
import CoreData

public class Contact: NSManagedObject {

    var fullName: String {
        get {
            var name = ""
            if let firstName = firstName {
                name += firstName
            }
            if let lastName = lastName {
                name += " \(lastName)"
            }
            return name
        }
    }
}

public func <(lhs: Contact, rhs: Contact) -> Bool {
    return lhs.fullName.lowercaseString < rhs.fullName.lowercaseString
}

public func >(lhs: Contact, rhs: Contact) -> Bool {
    return lhs.fullName.lowercaseString > rhs.fullName.lowercaseString
}

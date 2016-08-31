//
//  Contact.swift
//  VIPER Contacts Final
//
//  Created by Rafael Sacchi on 8/30/16.
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
                name += " " + lastName
            }
            return name
        }
    }

}

public struct ContactViewModel {
    var fullName = ""
}

public func <(lhs: ContactViewModel, rhs: ContactViewModel) -> Bool {
    return lhs.fullName.lowercaseString < rhs.fullName.lowercaseString
}

public func >(lhs: ContactViewModel, rhs: ContactViewModel) -> Bool {
    return lhs.fullName.lowercaseString > rhs.fullName.lowercaseString
}

//
//  Contact.swift
//  MVVM Contacts Starter
//
//  Created by Rafael Sacchi on 8/13/16.
//  Copyright © 2016 Rafael Sacchi. All rights reserved.
//

import Foundation

public class Contact {
    var firstName = ""
    var lastName = ""

    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }

    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
}

public struct DisplayContact {
    var fullName = ""
}

public func <(lhs: DisplayContact, rhs: DisplayContact) -> Bool {
    return lhs.fullName.lowercaseString < rhs.fullName.lowercaseString
}

public func >(lhs: DisplayContact, rhs: DisplayContact) -> Bool {
    return lhs.fullName.lowercaseString > rhs.fullName.lowercaseString
}

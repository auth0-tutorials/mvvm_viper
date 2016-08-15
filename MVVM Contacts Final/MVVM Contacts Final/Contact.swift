//
//  Contact.swift
//  MVVM Contacts Starter
//
//  Created by Rafael Sacchi on 8/13/16.
//  Copyright © 2016 Rafael Sacchi. All rights reserved.
//

import Foundation

public struct Contact: Equatable {
    var firstName = ""
    var lastName = ""

    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
}

public func ==(lhs: Contact, rhs: Contact) -> Bool {
    return lhs.fullName.lowercaseString == rhs.fullName.lowercaseString
}

public func <(lhs: Contact, rhs: Contact) -> Bool {
    return lhs.fullName.lowercaseString < rhs.fullName.lowercaseString
}

public func >(lhs: Contact, rhs: Contact) -> Bool {
    return lhs.fullName.lowercaseString > rhs.fullName.lowercaseString
}

public func <=(lhs: Contact, rhs: Contact) -> Bool {
    return lhs.fullName.lowercaseString <= rhs.fullName.lowercaseString
}

public func >=(lhs: Contact, rhs: Contact) -> Bool {
    return lhs.fullName.lowercaseString >= rhs.fullName.lowercaseString
}

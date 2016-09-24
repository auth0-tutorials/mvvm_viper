//
//  ContactViewModel.swift
//  MVVM Contacts Final
//
//  Created by Rafael Sacchi on 9/6/16.
//  Copyright © 2016 Rafael Sacchi. All rights reserved.
//

import Foundation

public struct ContactViewModel {
    var fullName: String
}

public func <(lhs: ContactViewModel, rhs: ContactViewModel) -> Bool {
    return lhs.fullName.lowercased() < rhs.fullName.lowercased()
}

public func >(lhs: ContactViewModel, rhs: ContactViewModel) -> Bool {
    return lhs.fullName.lowercased() > rhs.fullName.lowercased()
}

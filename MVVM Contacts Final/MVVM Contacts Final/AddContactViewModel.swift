//
//  AddContactViewModel.swift
//  MVVM Contacts Starter
//
//  Created by Rafael Sacchi on 8/13/16.
//  Copyright © 2016 Rafael Sacchi. All rights reserved.
//

import Foundation

protocol AddContactViewModelDelegate: class {
    func didAddContact(contact: Contact)
}

class AddContactViewModel {
    weak var delegate: AddContactViewModelDelegate?

    func addNewContact(firstName firstName: String, lastName: String) {
        let contact = Contact(firstName: firstName, lastName: lastName)
        delegate?.didAddContact(contact)
    }
}

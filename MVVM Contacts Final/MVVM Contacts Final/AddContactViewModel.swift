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
    var dataManager = AddContactLocalDataManager()

    func addNewContact(firstName firstName: String, lastName: String) {
        do {
            let contact = try dataManager.createContact(firstName: firstName, lastName: lastName)
            delegate?.didAddContact(contact)
        } catch {}
    }
}

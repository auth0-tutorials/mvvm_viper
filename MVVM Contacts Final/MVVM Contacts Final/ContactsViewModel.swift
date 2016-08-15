//
//  ContactsViewModel.swift
//  MVVM Contacts Starter
//
//  Created by Rafael Sacchi on 8/13/16.
//  Copyright © 2016 Rafael Sacchi. All rights reserved.
//

import Foundation

protocol ContactsViewModelProtocol: class {
    func didInsertContact(at index: Int)
}

class ContactsViewModel {

    weak var feedback: ContactsViewModelProtocol?
    private var contacts: [Contact] = [Contact(firstName: "Alan", lastName: "Smith"),
                                       Contact(firstName: "Beatrice", lastName: "Davies"),
                                       Contact(firstName: "Chloe", lastName: "Brown"),
                                       Contact(firstName: "Daniel", lastName: "Williams"),
                                       Contact(firstName: "Edward", lastName: "Robinson"),
                                       Contact(firstName: "Frankie", lastName: "Walker")]

    var contactsCount: Int {
        return contacts.count
    }

    func contactFullName(at index: Int) -> String {
        let contact = contacts[index]
        return contact.fullName
    }
}

extension ContactsViewModel: AddContactViewModelDelegate {
    func didAddContact(contact: Contact) {
        let insertionIndex = contacts.insertionIndex(of: contact) { $0 < $1 }
        contacts.insert(contact, atIndex: insertionIndex)
        feedback?.didInsertContact(at: insertionIndex)
    }
}

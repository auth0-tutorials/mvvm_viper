//
//  ContactsInteractor.swift
//  VIPER Contacts Starter
//
//  Created by Rafael Sacchi on 8/15/16.
//  Copyright © 2016 Rafael Sacchi. All rights reserved.
//

import Foundation

protocol ContactsInteractorOutput: class {
    func didRetrieveContacts(contacts: [Contact])
}

class ContactsInteractor {

    weak var delegate: ContactsInteractorOutput?

    func retrieveContacts() {
        let contacts = [Contact(firstName: "Alan", lastName: "Smith"),
                        Contact(firstName: "Beatrice", lastName: "Davies"),
                        Contact(firstName: "Chloe", lastName: "Brown"),
                        Contact(firstName: "Daniel", lastName: "Williams"),
                        Contact(firstName: "Edward", lastName: "Robinson"),
                        Contact(firstName: "Frankie", lastName: "Walker")]
        delegate?.didRetrieveContacts(contacts)
    }
}

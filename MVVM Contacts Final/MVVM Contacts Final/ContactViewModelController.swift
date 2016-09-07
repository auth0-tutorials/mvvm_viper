//
//  ContactViewModelController.swift
//  MVVM Contacts Final
//
//  Created by Rafael Sacchi on 9/5/16.
//  Copyright © 2016 Rafael Sacchi. All rights reserved.
//

import Foundation

protocol ContactViewModelControllerDelegate {
    func didFetchContacts()
    func didFailFetchingContacts()

    func didAddContact(contact: ContactViewModel, at index: Int)
    func didFailAddingContact()
}

class ContactViewModelController {

    private var contactViewModelList: [ContactViewModel] = []
    private var dataManager = ContactLocalDataManager()

    var contactsCount: Int {
        return contactViewModelList.count
    }

    func retrieveContacts(success: (() -> Void)?, failure: (() -> Void)?) {
        do {
            let contacts = try dataManager.retrieveContactList()
            contactViewModelList = contacts.map() { ContactViewModel(fullName: $0.fullName) }
            success?()
        } catch {
            failure?()
        }
    }

    func viewModel(at index: Int) -> ContactViewModel {
        return contactViewModelList[index]
    }

    func createContact(firstName firstName: String, lastName: String,
                                 success: ((ContactViewModel, Int) -> Void)?,
                                 failure: (() -> Void)?) {
        do {
            let contact = try dataManager.createContact(firstName: firstName, lastName: lastName)
            let contactViewModel = ContactViewModel(fullName: contact.fullName)
            let insertionIndex = contactViewModelList.insertionIndex(of: contactViewModel) { $0 < $1 }
            contactViewModelList.insert(contactViewModel, atIndex: insertionIndex)
            success?(contactViewModel, insertionIndex)
        } catch {
            failure?()
        }
    }

}

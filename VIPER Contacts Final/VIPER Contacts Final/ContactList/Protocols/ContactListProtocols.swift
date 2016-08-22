//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation
import UIKit

protocol ContactListViewProtocol: class {
    var presenter: ContactListPresenterProtocol? { get set }

    // PRESENTER -> VIEW
    func reloadInterface(with data: [DisplayContact])
    func insert(contact displayContact: DisplayContact, at index: Int)
}

protocol ContactListWireFrameProtocol: class {
    static func createContactListModule() -> UIViewController

    // PRESENTER -> WIREFRAME
    func presentAddContactScreen(fromView view: ContactListViewProtocol)
}

protocol ContactListPresenterProtocol: class {
    var view: ContactListViewProtocol? { get set }
    var interactor: ContactListInteractorInputProtocol? { get set }
    var wireFrame: ContactListWireFrameProtocol? { get set }

    // VIEW -> PRESENTER
    func retrieveContacts()
    func addNewContact(fromView view: ContactListView)
}

protocol ContactListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER

    func didRetrieveContacts(contacts: [Contact])
}

protocol ContactListInteractorInputProtocol: class {
    var presenter: ContactListInteractorOutputProtocol? { get set }
    var APIDataManager: ContactListAPIDataManagerInputProtocol? { get set }
    var localDatamanager: ContactListLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func retrieveContacts()
}

protocol ContactListDataManagerInputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol ContactListAPIDataManagerInputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol ContactListLocalDataManagerInputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
}

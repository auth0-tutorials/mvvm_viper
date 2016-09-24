//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import UIKit
import CoreData

protocol AddModuleDelegate: class {
    func didAddContact(_ contact: Contact)
    func didCancelAddContact()
}

protocol AddContactViewProtocol: class {
    var presenter: AddContactPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol AddContactWireFrameProtocol: class {
    static func createAddContactModule(with delegate: AddModuleDelegate) -> UIViewController
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
    func dismissAddContactInterface(from view: AddContactViewProtocol, completion: (() -> Void)?)
}

protocol AddContactPresenterProtocol: class {
    var view: AddContactViewProtocol? { get set }
    var interactor: AddContactInteractorInputProtocol? { get set }
    var wireFrame: AddContactWireFrameProtocol? { get set }
    var delegate: AddModuleDelegate? { get set }

    // VIEW -> PRESENTER
    func cancelAddContactAction()
    func addNewContact(firstName: String, lastName: String)
}

protocol AddContactInteractorOutputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol AddContactInteractorInputProtocol: class {
    var presenter: AddContactInteractorOutputProtocol? { get set }
    var APIDataManager: AddContactAPIDataManagerInputProtocol? { get set }
    var localDatamanager: AddContactLocalDataManagerInputProtocol? { get set }

    // PRESENTER -> INTERACTOR
    func saveNewContact(firstName: String, lastName: String) -> Contact?
}

protocol AddContactDataManagerInputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol AddContactAPIDataManagerInputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol AddContactLocalDataManagerInputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
    func createContact(firstName: String, lastName: String) throws -> Contact
}

//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation
import UIKit

protocol AddModuleDelegate: class {
    func didAddContact(contact: Contact)
    func didCancelAddContact()
}

protocol VIPERViewProtocol: class {
    var presenter: VIPERPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol VIPERWireFrameProtocol: class {
    static func createAddContactModule(with delegate: AddModuleDelegate) -> UIViewController
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
    func dismissAddContactInterface(from view: VIPERViewProtocol, completion: (() -> Void)?)
}

protocol VIPERPresenterProtocol: class {
    var view: VIPERViewProtocol? { get set }
    var interactor: VIPERInteractorInputProtocol? { get set }
    var wireFrame: VIPERWireFrameProtocol? { get set }
    var delegate: AddModuleDelegate? { get set }

    // VIEW -> PRESENTER
    func cancelAddContactAction()
    func addNewContact(firstName firstName: String, lastName: String)
}

protocol VIPERInteractorOutputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol VIPERInteractorInputProtocol: class {
    var presenter: VIPERInteractorOutputProtocol? { get set }
    var APIDataManager: VIPERAPIDataManagerInputProtocol? { get set }
    var localDatamanager: VIPERLocalDataManagerInputProtocol? { get set }

    // PRESENTER -> INTERACTOR
    func saveNewContact(firstName firstName: String, lastName: String) -> Contact
}

protocol VIPERDataManagerInputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol VIPERAPIDataManagerInputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol VIPERLocalDataManagerInputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
}

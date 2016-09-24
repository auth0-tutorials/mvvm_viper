import UIKit

protocol ContactListViewProtocol: class {
    var presenter: ContactListPresenterProtocol? { get set }

    // PRESENTER -> VIEW
    func didInsertContact(_ contact: ContactViewModel)
    func reloadInterface(with contacts: [ContactViewModel])
}

protocol ContactListWireFrameProtocol: class {
    static func createContactListModule() -> UIViewController

    // PRESENTER -> WIREFRAME
    func presentAddContactScreen(from view: ContactListViewProtocol)
}

protocol ContactListPresenterProtocol: class {
    var view: ContactListViewProtocol? { get set }
    var interactor: ContactListInteractorInputProtocol? { get set }
    var wireFrame: ContactListWireFrameProtocol? { get set }

    // VIEW -> PRESENTER
    func viewDidLoad()
    func addNewContact(from view: ContactListViewProtocol)
}

protocol ContactListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER

    func didRetrieveContacts(_ contacts: [Contact])
}

protocol ContactListInteractorInputProtocol: class {
    var presenter: ContactListInteractorOutputProtocol? { get set }
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

protocol ContactListLocalDataManagerInputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
    func retrieveContactList() throws -> [Contact]
}

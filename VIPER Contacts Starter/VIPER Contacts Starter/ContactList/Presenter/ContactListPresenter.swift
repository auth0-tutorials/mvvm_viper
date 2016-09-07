import Foundation

class ContactListPresenter: ContactListPresenterProtocol {
    weak var view: ContactListViewProtocol?
    var interactor: ContactListInteractorInputProtocol?
    var wireFrame: ContactListWireFrameProtocol?

    func viewDidLoad() {}

    func addNewContact(from view: ContactListViewProtocol) {}

}

extension ContactListPresenter: ContactListInteractorOutputProtocol {

    func didRetrieveContacts(contacts: [Contact]) {}

}

extension ContactListPresenter: AddModuleDelegate {

    func didAddContact(contact: Contact) {}

    func didCancelAddContact() {}

}

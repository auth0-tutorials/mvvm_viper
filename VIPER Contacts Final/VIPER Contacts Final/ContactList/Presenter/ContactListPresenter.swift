
class ContactListPresenter: ContactListPresenterProtocol {
    weak var view: ContactListViewProtocol?
    var interactor: ContactListInteractorInputProtocol?
    var wireFrame: ContactListWireFrameProtocol?

    func viewDidLoad() {
        interactor?.retrieveContacts()
    }

    func addNewContact(from view: ContactListViewProtocol) {
        wireFrame?.presentAddContactScreen(from: view)
    }

}

extension ContactListPresenter: ContactListInteractorOutputProtocol {

    func didRetrieveContacts(_ contacts: [Contact]) {
        view?.reloadInterface(with: contacts.map() {
            return ContactViewModel(fullName: $0.fullName)
        })
    }

}

extension ContactListPresenter: AddModuleDelegate {

    func didAddContact(_ contact: Contact) {
        let contactViewModel = ContactViewModel(fullName: contact.fullName)
        view?.didInsertContact(contactViewModel)
    }

    func didCancelAddContact() {}

}

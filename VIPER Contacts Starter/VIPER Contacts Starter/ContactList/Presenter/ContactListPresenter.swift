
class ContactListPresenter: ContactListPresenterProtocol {
    weak var view: ContactListViewProtocol?
    var interactor: ContactListInteractorInputProtocol?
    var wireFrame: ContactListWireFrameProtocol?

    func viewDidLoad() {}

    func addNewContact(from view: ContactListViewProtocol) {}

}

extension ContactListPresenter: ContactListInteractorOutputProtocol {

    func didRetrieveContacts(_ contacts: [Contact]) {}

}

extension ContactListPresenter: AddModuleDelegate {

    func didAddContact(_ contact: Contact) {}

    func didCancelAddContact() {}

}

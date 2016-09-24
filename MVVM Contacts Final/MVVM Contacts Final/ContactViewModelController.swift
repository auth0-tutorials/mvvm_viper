
class ContactViewModelController {

    fileprivate var contactViewModelList: [ContactViewModel] = []
    fileprivate var dataManager = ContactLocalDataManager()

    var contactsCount: Int {
        return contactViewModelList.count
    }

    func retrieveContacts(_ success: (() -> Void)?, failure: (() -> Void)?) {
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

    func createContact(firstName: String, lastName: String,
                                 success: ((ContactViewModel, Int) -> Void)?,
                                 failure: (() -> Void)?) {
        do {
            let contact = try dataManager.createContact(firstName: firstName, lastName: lastName)
            let contactViewModel = ContactViewModel(fullName: contact.fullName)
            let insertionIndex = contactViewModelList.insertionIndex(of: contactViewModel) { $0 < $1 }
            contactViewModelList.insert(contactViewModel, at: insertionIndex)
            success?(contactViewModel, insertionIndex)
        } catch {
            failure?()
        }
    }

}

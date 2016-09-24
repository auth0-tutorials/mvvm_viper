import UIKit

class ContactsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    let contactViewModelController = ContactViewModelController()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        contactViewModelController.retrieveContacts({ [unowned self] in
            self.tableView.reloadData()
        }, failure: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addContactNavigationController = segue.destination as? UINavigationController
        let addContactVC = addContactNavigationController?.viewControllers[0] as? AddContactViewController

        addContactVC?.contactsViewModelController = contactViewModelController
        addContactVC?.didAddContact = { [unowned self] (contactViewModel, index) in
            let indexPath = IndexPath(row: index, section: 0)
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [indexPath], with: .left)
            self.tableView.endUpdates()
        }
    }

}

extension ContactsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as? ContactsTableViewCell
        guard let contactsCell = cell else {
            return UITableViewCell()
        }

        contactsCell.cellModel = contactViewModelController.viewModel(at: (indexPath as NSIndexPath).row)
        return contactsCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactViewModelController.contactsCount
    }

}

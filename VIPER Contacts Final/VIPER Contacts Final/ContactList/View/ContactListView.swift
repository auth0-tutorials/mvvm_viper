import Foundation
import UIKit

class ContactListView: UIViewController {

    @IBOutlet var tableView: UITableView!
    var presenter: ContactListPresenterProtocol?
    var contactList: [ContactViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()

        tableView.tableFooterView = UIView()
    }

    @IBAction func didClickOnAddButton(sender: UIBarButtonItem) {
        presenter?.addNewContact(from: self)
    }

}

extension ContactListView: ContactListViewProtocol {

    func reloadInterface(with contacts: [ContactViewModel]) {
        contactList = contacts
        tableView.reloadData()
    }

    func didInsertContact(contact: ContactViewModel) {
        let insertionIndex = contactList.insertionIndex(of: contact) { $0 < $1 }
        contactList.insert(contact, atIndex: insertionIndex)

        let indexPath = NSIndexPath(forRow: insertionIndex, inSection: 0)
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Right)
        tableView.endUpdates()
    }

}

extension ContactListView: UITableViewDataSource {

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = contactList[indexPath.row].fullName
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }

}

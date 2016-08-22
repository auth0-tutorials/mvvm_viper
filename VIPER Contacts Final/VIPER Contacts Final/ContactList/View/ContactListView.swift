//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation
import UIKit

class ContactListView: UIViewController {

    @IBOutlet var tableView: UITableView!
    var presenter: ContactListPresenterProtocol?
    var contacts: [DisplayContact] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        presenter?.retrieveContacts()
    }

    @IBAction func didClickOnAddButton(sender: UIBarButtonItem) {
        presenter?.addNewContact(fromView: self)
    }

}

extension ContactListView: ContactListViewProtocol {

    func insert(contact displayContact: DisplayContact, at index: Int) {
        contacts.insert(displayContact, atIndex: index)
        let toInsert = NSIndexPath(forRow: index, inSection: 0)
        tableView.insertRowsAtIndexPaths([toInsert], withRowAnimation: .Left)
    }

    func reloadInterface(with data: [DisplayContact]) {
        contacts = data
        tableView.reloadData()
    }

}

extension ContactListView: UITableViewDataSource {

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = contacts[indexPath.row].fullName
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

}

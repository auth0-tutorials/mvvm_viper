//
//  ViewController.swift
//  MVVM Contacts Starter
//
//  Created by Rafael Sacchi on 8/13/16.
//  Copyright © 2016 Rafael Sacchi. All rights reserved.
//

import UIKit
import Foundation

class ContactsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var presenter: ContactsPresenter?
    var contacts: [DisplayContact] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()

        presenter = ContactsPresenter(viewController: self)
        presenter?.delegate = self
        presenter?.retrieveContacts()
    }

    @IBAction func didClickOnAddButton(sender: UIBarButtonItem) {
        presenter?.addNewContact()
    }

}

extension ContactsViewController: ContactsInterface {

    func reloadInterface(with data: [DisplayContact]) {
        contacts = data
        tableView.reloadData()
    }

}

extension ContactsViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell")!
        cell.textLabel?.text = contacts[indexPath.row].fullName
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
}

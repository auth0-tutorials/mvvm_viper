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
    let viewModel = ContactsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        viewModel.feedback = self
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let addContactNavigationController = segue.destinationViewController as? UINavigationController
        let addContactVC = addContactNavigationController?.viewControllers[0] as? AddContactViewController
        addContactVC?.delegate = viewModel
    }

}

extension ContactsViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell")!
        cell.textLabel?.text = viewModel.contactFullName(at: indexPath.row)
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactsCount
    }

}

extension ContactsViewController: ContactsViewModelProtocol {

    func didInsertContact(at index: Int) {
        let indexPath = NSIndexPath(forRow: index, inSection: 0)
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Right)
        tableView.endUpdates()
    }
}

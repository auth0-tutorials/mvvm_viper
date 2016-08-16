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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

}

extension ContactsViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("ContactCell")!
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

}

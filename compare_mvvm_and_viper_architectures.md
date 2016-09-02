---
layout: post
title: "Compare MVVM and Viper architectures: when to use one or the other"
description: "How MVVM and VIPER can be good alternatives to the traditinal MVC in iOS projects"
date: 2016-08-10 8:30
alias: /2016/08/10/Compare-mvvm-and-viper-architectures-when-to-use-one-or-the-other/
author:
  name: Rafael Sacchi
  url: https://twitter.com/rafael_sacchi?lang=en
  mail: rafaelmsacchi@gmail.com
  avatar: http://www.gravatar.com/avatar/b7e1e53144c06ecfdef91f0e4229a08a
design:
  bg_color: "#2d5487"
  image: https://cdn.auth0.com/blog/customer-data/customer-data-icon.png
tags:
- mvvm
- viper
- ios
- architecture
- mvc
---

---

**TL;DR**: A well designed architecture is important to keep a project maintainable in the long term. In this article, we'll compare MVVM and VIPER for iOS projects as an alternative to the traditional MVC.

---

[MVC](https://en.wikipedia.org/wiki/Model–view–controller) is a well-known concept for those who have been developing software for a reasonable length of time. It's an acronym for **Model View Controller**, meaning that your project will be structured in 3 parts: _Model_, representing the entities; _View_, representing the interface with which the user interacts; and _Controller_, responsible for connecting the other two pieces. That's how Apple recomends us to organize our iOS projects - which means that everything that is not a View or Model is part of the Controller layer.

However, you problably know that projects can be highly complex: handling network requests, parsing responses, accessing data models, formatting data for the interface, responding to interface events, and so on. You'll end up with enormous Controllers, responsible for all these different things and not reusable at all. In other words, MVC is a nightmare for developers in charge of the maintenance of a project. But how can we accomplish a better separation of concerns and reusability for iOS projects?

We'll explore two popular alternatives for MVC: MVVM and VIPER. Both are gaining popularity in the iOS community, and proved to be good ways to go instead of the traditional MVC (gently nicknamed as [Massive View Controller](https://twitter.com/Colin_Campbell/status/293167951132098560)). We'll talk about how these two different architectures are structured, build an example application and compare when it's the case to use one or the other.

## MVVM with example

### How it works

MVVM stands for **Model-View-ViewModel**. It's a different way to arrange responsibilities, changing a few roles compared to MVC.

1. **Model** - This is the layer that does not change if compared to MVC. It still represents the data-model layer of your application, and can hold business logic responsibilities as well. You may also want to create a manager class to manipulate the model objects and a network manager class to handle requests and data parsing.

2. **View** - Here things start to change. The _View_ layer in MVVM englobes the interface (UIView subclasses, xib and storyboard files), the view logic (animations, drawing) and handling user input events (button clicks, transitions, etc). Those are responsibilities of the _View_ and the _Controller_ in the MVC. This means that your views will remain the same, while your controllers will only contain a small subset of the responsibilities they have in MVC - and will get reasonably smaller than usual

3. **ViewModel** - That's the new home for most of your usual Controller code. _ViewModel_ will request the data from the model layer (it might be a local access to a database or a network request) and pass it back to the view, formatted in the way it will be displayed. But it's a two-way mechanism: user input, when necessary, will also get through the ViewModel to update the Model. Since the ViewModel controls exactly what is being displayed, it's useful to use some data binding mechanism between the two layers. 

Comparing to MVC, you change from a architecture that looks like this:

// image

For something that looks like this:

// image

In which the View layer corresponds to UIView and UIViewController classes and subclasses.

Now it's time to get hands dirty to grasp the new concepts. So let's build an example app structured using MVVM!

### MVVM Contacts App

We'll build a Contacts app. You can follow the example in the _MVVM Contacts Starter_ folder in [this repository](https://github.com/auth0-tutorials/mvvm_viper/).

The app has two screens: the first is a list of contacts, displayed in table view with their full name and a placeholder profile image.

<img src="img/contacts.png" width="300">

The second is an Add Contact screen, with first/last name text fields and cancel/done button items.

<img src="img/add_contact.png" width="300">

#### Model <a id="model"></a>

The following code is a class to represent the contact and two operator overloading functions. Put it in the **Contact.swift** file.

```swift
public class Contact {
    var firstName = ""
    var lastName = ""

    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }

    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
}

public func <(lhs: Contact, rhs: Contact) -> Bool {
    return lhs.fullName.lowercaseString < rhs.fullName.lowercaseString
}

public func >(lhs: Contact, rhs: Contact) -> Bool {
    return lhs.fullName.lowercaseString > rhs.fullName.lowercaseString
}
```
A Contact has only these two fields, _firstName_ and _lastName_. A stored property is responsible for returning the _fullName_, and the operators _>_ and _<_ have their implementation to be used when an instance is inserted in a ordered list.

#### View

There are three files responsible for the view layer: the **Main** storyboard, with views already laid out in the starter project; the **ContactsViewController**, that displays the contacts list in a table view; and the **AddContactViewController**, with two labels and fields for setting up the first and last name of a new contact. Let's start with the code for **ContactsViewController**:

```swift
class ContactsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    let viewModel = ContactsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        viewModel.contactsViewModelProtocol = self
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
```

A quick look is enough to realize that this class has mostly interface responsibilities. It also has navigation flow dependency in __prepareForSegue(::)__ - something that will change in VIPER with the Router layer.

Now take a closer look at the class extension that conforms to the _UITableViewDataSource_ protocol. The implemented functions don't interact directly with the __Contact__ class in the Model layer - instead, it gets the data the way it will be displayed, already formatted by the __ViewModel__.

Same thing for the class extension that conforms to the _ContactsViewModelProtocol_ protocol. It's only notified that a new _Contact_ instance was added to the data source, so its work is to insert a new row in the table view - that's only an interface update.

Now update your **AddContactViewController.swift** file with the following code:

```swift
class AddContactViewController: UIViewController {

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    let viewModel = AddContactViewModel()
    weak var delegate: AddContactViewModelDelegate? {
        didSet {
            viewModel.delegate = delegate
        }
    }

    @IBAction func didClickOnDoneButton(sender: UIBarButtonItem) {
        guard let firstName = firstNameTextField.text else {
            return
        }
        guard let lastName = lastNameTextField.text else {
            return
        }
        if firstName.isEmpty || lastName.isEmpty {
            showEmptyNameAlert()
            return
        }
        dismissViewControllerAnimated(true) { [unowned self] in
            self.viewModel.addNewContact(firstName: firstName, lastName: lastName)
        }
    }

    @IBAction func didClickOnCancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    private func showEmptyNameAlert() {
        let alertView = UIAlertController(title: "Error",
                                          message: "A contact must have first and last names",
                                          preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .Destructive, handler: nil))
        presentViewController(alertView, animated: true, completion: nil)
    }

}
```
Again, mostly UI operations. Note that it delegates to the View Model the responsibility of creating a new _Contact_ instance on _didClickOnDoneButton(:)_.

#### View Model

Time to talk about the new kid in town: the View Model layer. First, insert the following code in the **ContactsViewModel.swift** file.

```swift
protocol ContactsViewModelProtocol: class {
    func didInsertContact(at index: Int)
}

class ContactsViewModel {

    weak var contactsViewModelProtocol: ContactsViewModelProtocol?
    private var contacts: [Contact] = [Contact(firstName: "Alan", lastName: "Smith"),
                                       Contact(firstName: "Beatrice", lastName: "Davies"),
                                       Contact(firstName: "Chloe", lastName: "Brown"),
                                       Contact(firstName: "Daniel", lastName: "Williams"),
                                       Contact(firstName: "Edward", lastName: "Robinson"),
                                       Contact(firstName: "Frankie", lastName: "Walker")]

    var contactsCount: Int {
        return contacts.count
    }

    func contactFullName(at index: Int) -> String {
        let contact = contacts[index]
        return contact.fullName
    }
}

extension ContactsViewModel: AddContactViewModelDelegate {
    func didAddContact(contact: Contact) {
        let insertionIndex = contacts.insertionIndex(of: contact) { $0 < $1 }
        contacts.insert(contact, atIndex: insertionIndex)
        contactsViewModelProtocol?.didInsertContact(at: insertionIndex)
    }
}
```

First thing to remember as a rule of thumb: View Model is not responsible for user interface. A way to guarantee that you're not messing things up is to **never** import UIKit in a View Model file.

This file has a few mocked contacts and tries to not expose the Model layer. It returns the data formatted in the way that the view asks, and notifies the view that there are changes in the data source when a new contact is added.

Finally, the last file to be updated is **AddContactViewModel.swift**.

```swift
protocol AddContactViewModelDelegate: class {
    func didAddContact(contact: Contact)
}

class AddContactViewModel {
    weak var delegate: AddContactViewModelDelegate?

    func addNewContact(firstName firstName: String, lastName: String) {
        let contact = Contact(firstName: firstName, lastName: lastName)
        delegate?.didAddContact(contact)
    }
}
```

This is the simplest file of all. It only creates a new contact and notifies its delegate of the creation, which happens to be the _ContactsViewModel_. In a real world scenario, this would involve performing a network request and/or inserting in a local database. But none of them should be a View Model role - networking and database should have their own managers.

That's it for MVVM. You may find this approach more testable, mantainable and distributed than usual MVC. So let's talk about VIPER and check how the two architecture styles compare.

## VIPER with example

### How it works

VIPER is an application of the [Clean Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html) to iOS projects. It stands for View, Interactor, Presenter, Entity, and Router. It's a really segmented way to divide responsibilities, fits very well with unit testing and makes your code more reusable. 

// image

1. View - It's the interface layer, which means UIKit files (including UIViewController). At this point, it's quite clear that UIViewController subclasses should belong to the View layer in a more decoupled architecture. In VIPER, things are basically the same of those in MVVM: views are responsible for displaying what the presenter asks them to, and to transmit user input back to the Presenter.

2. Interactor - Contains the business logic that are described by the use cases in the application. Similar to the ViewModel, the interactor is responsible for fetching data from the model layer (using network or local database), and its implementation is totally independent of the UI. It's important to remember that network and database managers are not part of VIPER, so they are treated as separated dependencies.

3. Presenter - Contains view logic to format data to be displayed. In MVVM, this is part of the job done by the ViewModel. The Presenter receives data from the Interactor and carry it to the View. Also, it reacts to user inputs, asking for more data or sending it back to the Interactor.

4. Entity - Has the responsibilities of the Model layer in the other architectures. Entities are plain data objects, managed by the Interactor.

5. Router - The navigation logic of the application. It might not seem an important layer, but if you have to reuse the same iPhone views in a iPad, the only thing that might change is the way that the views are presented. This lets your other layers untouched, and the Router is responsible for the navigation flow in each situation.

Comparing to MVX styles, Viper has a few key differences in the distribution of responsibilities:
- It introduces Router, the layer responsible for the navigation flow.
- Entities are plain data structures, transferring the access logic that usually belongs to Model to the Interactor.
- ViewModel (and Controller in MVC) responsibilities are shared among Interactor and Presenter.

Again, it's time to get the hands dirty and explore the VIPER architecture with an example app. For the sake of simplicity, we will explore only the Contact List module. The code for the Add Contact module can be found in the starter project (_VIPER Contacts Starter_ folder in [this repository](https://github.com/auth0-tutorials/mvvm_viper/)).

> Note: if you consider making your application based in VIPER, please do not create all files manually - you can check a VIPER generator code like [VIPER gen](https://github.com/pepibumur/viper-module-generator?utm_source=swifting.io) or [Generamba](https://github.com/rambler-ios/Generamba).

### Contacts App

#### View

The view is represented by the elements in the **Main.storyboard** file and the **ContactListView** class. It is passive; only passes interface events along to the presenter, and updates itself when notified by the presenter. Put the following code in the **ContactListView.swift**.

```swift
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
```

The view sends _viewDidLoad_ and _didClickOnAddButton_ events to the presenter. In the former, the presenter will ask the interactor for data; in the latter, the presenter will ask the route layer to present the Add Contact module.

Methods from _ContactListViewProtocol_ are called from the presenter, either when the contacts list is retrieved or when a new contact is added. In both situations, the data in the view only contains the information needed for display.

Finally, there are the implementations of the _UITableViewDataSource_ methods, updating the interface elements with the retrieved data.

#### Interactor

The interactor in our example is quite simple. It only asks the local data manager for data - it does not care if the local manager is using Core Data, [Realm](https://realm.io) or any other data storage solution. The following code is part of the **ContactListInteractor.swift** file:

```swift
import Foundation

class ContactListInteractor: ContactListInteractorInputProtocol {
    weak var presenter: ContactListInteractorOutputProtocol?
    var localDatamanager: ContactListLocalDataManagerInputProtocol?

    func retrieveContacts() {
        do {
            if let contactList = try localDatamanager?.retrieveContactList() {
                presenter?.didRetrieveContacts(contactList)
            } else {
                presenter?.didRetrieveContacts([])
            }

        } catch {
            presenter?.didRetrieveContacts([])
        }
    }

}
```
After retrieving data, the interactor notifies the presenter and sends what was retrieved. As an alternative for this implementation, the interactor can also [propagate the error](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ErrorHandling.html#//apple_ref/doc/uid/TP40014097-CH42-ID508) to the presenter, which will then be responsible for formatting a error object to be displayed in the view.

> Note: as you may have noticed, each layer in VIPER is implementing a protocol. This way, classes depend on abstractions instead of concretions, conforming to the Dependency Inversion principle.

#### Presenter

This is the central point in the VIPER architecture. The communication between view and the other layers (interactor and and router) passes through the presenter. Let's see how things work by placing the following code in the **ContactListPresenter.swift** file.

```swift
import Foundation

class ContactListPresenter: ContactListPresenterProtocol {
    weak var view: ContactListViewProtocol?
    var interactor: ContactListInteractorInputProtocol?
    var wireFrame: ContactListWireFrameProtocol?

    func viewDidLoad() {
        interactor?.retrieveContacts()
    }

    func addNewContact(from view: ContactListView) {
        wireFrame?.presentAddContactScreen(from: view)
    }

}

extension ContactListPresenter: ContactListInteractorOutputProtocol {

    func didRetrieveContacts(contacts: [Contact]) {
        view?.reloadInterface(with: contacts.map() {
            return ContactViewModel(fullName: $0.fullName)
        })
    }

}

extension ContactListPresenter: AddModuleDelegate {

    func didAddContact(contact: Contact) {
        let contactViewModel = ContactViewModel(fullName: contact.fullName)
        view?.didInsertContact(contactViewModel)
    }

    func didCancelAddContact() {}

}
```

When the view is loaded, it notifies the presenter, which asks the interactor for data. When the add button is clicked, it notifies the presenter, which asks the router layer to show the add contacts screen.

Also, when the contacts list is retrieved, the presenter formats the data and sends it back to the view. It is also responsible for implementing the Add Contact module delegate. This means that the presenter will be notified when a new contact is added, format it and send it to the view.

As you may have noticed, presenters might get large. When this happens, it is interesting to separate it in two modules: the presenter, which will only receives data and format it back to the view; and event handler, which will respond to interface events.

#### Entity

This layer is similar to the Model layer in MVVM. In our contacts app, it is represented by the **Contact** class and its operator overloading functions. Put the same code found [here](#model) in the **Contact.swift** file, and add the following View Model struct.

```swift
public struct ContactViewModel {
    var fullName = ""
}
```

The view model contains the fields that the presenter formats and view needs to display. The _Contact_ class is a subclass of _NSManagedObject_, containing the entity fields exactly as it is in the Core Data model.

#### Router

Last but not least, there is the router layer. The responsibility of navigating between modules is shared between the presenter and the wireframe. The presenter receives the user input and knows when to navigate, and the wireframe knows how to navigate. Put the following code in the **ContactListWireFrame.swift** file.

```swift
import Foundation
import UIKit

class ContactListWireFrame: ContactListWireFrameProtocol {

    class func createContactListModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewControllerWithIdentifier("ContactsNavigationController")
        if let view = navController.childViewControllers.first as? ContactListView {
            let presenter: protocol<ContactListPresenterProtocol, ContactListInteractorOutputProtocol> = ContactListPresenter()
            let interactor: ContactListInteractorInputProtocol = ContactListInteractor()
            let localDataManager: ContactListLocalDataManagerInputProtocol = ContactListLocalDataManager()
            let wireFrame: ContactListWireFrameProtocol = ContactListWireFrame()

            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager

            return navController
        }
        return UIViewController()
    }

    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    }

    func presentAddContactScreen(from view: ContactListViewProtocol) {

        guard let delegate = view.presenter as? AddModuleDelegate else {
            return
        }

        let addContactsView = AddContactWireFrame.createAddContactModule(with: delegate)
        if let sourceView = view as? UIViewController {
            sourceView.presentViewController(addContactsView, animated: true, completion: nil)
        }
    }

}
```

Since the wireframe is responsible for creating a module, it is convenient to set all the dependencies here. When presenting another module, the wireframe receives the object which will present it, and asks another wireframe for the presented module. It also passes the required data for the created module (in this case, only a delegate to receive the added contact).

The router layer brings a good opportunity to [avoid using storyboards segues](https://www.toptal.com/ios/ios-user-interfaces-storyboards-vs-nibs-vs-custom-code) and deal with view controller transitions on code. Since storyboards don't offer a decent solution for passing data between view controllers, this doesn't always mean more code. All we get is more reusability, better separation of concerns and maintanability of a project.

### Conclusion

You can find all projects (VIPER and MVVM - Starter and Final) in [this repository](https://github.com/auth0-tutorials/mvvm_viper/).

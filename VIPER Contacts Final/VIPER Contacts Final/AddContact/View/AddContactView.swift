import Foundation
import UIKit

class AddContactView: UIViewController, AddContactViewProtocol {
    var presenter: AddContactPresenterProtocol?

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.becomeFirstResponder()
    }

    @IBAction func didClickOnDoneButton(sender: UIBarButtonItem) {
        guard
            let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text
            else {
                return
        }

        if firstName.isEmpty || lastName.isEmpty {
            showEmptyNameAlert()
            return
        }
        presenter?.addNewContact(firstName: firstName, lastName: lastName)
    }

    @IBAction func didClickOnCancelButton(sender: UIBarButtonItem) {
        presenter?.cancelAddContactAction()
    }

    private func showEmptyNameAlert() {
        let alertView = UIAlertController(title: "Error",
                                          message: "A contact must have first and last names",
                                          preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .Destructive, handler: nil))
        presentViewController(alertView, animated: true, completion: nil)
    }
}

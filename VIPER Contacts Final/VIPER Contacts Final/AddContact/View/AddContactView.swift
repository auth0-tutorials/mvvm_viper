import UIKit

class AddContactView: UIViewController, AddContactViewProtocol {
    var presenter: AddContactPresenterProtocol?

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.becomeFirstResponder()
    }

    @IBAction func didClickOnDoneButton(_ sender: UIBarButtonItem) {
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

    @IBAction func didClickOnCancelButton(_ sender: UIBarButtonItem) {
        presenter?.cancelAddContactAction()
    }

    fileprivate func showEmptyNameAlert() {
        let alertView = UIAlertController(title: "Error",
                                          message: "A contact must have first and last names",
                                          preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
}

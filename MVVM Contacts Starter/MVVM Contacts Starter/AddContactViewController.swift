import UIKit

class AddContactViewController: UIViewController {

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!

    @IBAction func didClickOnDoneButton(_ sender: UIBarButtonItem) {
    }

    @IBAction func didClickOnCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}

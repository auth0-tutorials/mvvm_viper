import UIKit

class ContactsTableViewCell: UITableViewCell {
    var cellModel: ContactViewModel? {
        didSet {
            bindViewModel()
        }
    }

    func bindViewModel() {
        textLabel?.text = cellModel?.fullName
    }
}

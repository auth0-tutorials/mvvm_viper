//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation
import UIKit

class ContactListWireFrame: ContactListWireFrameProtocol {

    class func createContactListModule() -> UIViewController {
        // Generating module components
        let navController = mainStoryboard.instantiateViewControllerWithIdentifier("ContactsNavigationController")
        if let view = navController.childViewControllers.first as? ContactListView {
            let presenter: protocol<ContactListPresenterProtocol, ContactListInteractorOutputProtocol> = ContactListPresenter()
            let interactor: ContactListInteractorInputProtocol = ContactListInteractor()
            let APIDataManager: ContactListAPIDataManagerInputProtocol = ContactListAPIDataManager()
            let localDataManager: ContactListLocalDataManagerInputProtocol = ContactListLocalDataManager()
            let wireFrame: ContactListWireFrameProtocol = ContactListWireFrame()

            // Connecting
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.APIDataManager = APIDataManager
            interactor.localDatamanager = localDataManager

            return navController
        }
        return UIViewController()
    }

    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    }

    var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    }

    func presentAddContactScreen(fromView view: ContactListViewProtocol) {

        guard let delegate = view.presenter as? AddModuleDelegate else {
            return
        }

        let addContactsView = VIPERWireFrame.createAddContactModule(withDelegate: delegate)
        if let sourceView = view as? UIViewController {
            sourceView.presentViewController(addContactsView, animated: true, completion: nil)
        }
    }

}

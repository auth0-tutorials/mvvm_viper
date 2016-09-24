//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import UIKit

class AddContactWireFrame: AddContactWireFrameProtocol {

    class func createAddContactModule(with delegate: AddModuleDelegate) -> UIViewController {

        let navController = mainStoryboard.instantiateViewController(withIdentifier: "AddContactsNavigationController")
        if let view = navController.childViewControllers.first as? AddContactViewProtocol {
            // Generating module components
            let presenter: AddContactPresenterProtocol & AddContactInteractorOutputProtocol = AddContactPresenter()
            let interactor: AddContactInteractorInputProtocol = AddContactInteractor()
            let localDataManager: AddContactLocalDataManagerInputProtocol = AddContactLocalDataManager()
            let wireFrame: AddContactWireFrameProtocol = AddContactWireFrame()

            // Connecting
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            presenter.delegate = delegate
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager

            return navController
        }
        return UIViewController()
    }

    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }

    func dismissAddContactInterface(from view: AddContactViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true, completion: completion)
        }
    }

}

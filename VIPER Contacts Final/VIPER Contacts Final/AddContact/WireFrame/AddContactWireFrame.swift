//
// Created by AUTHOR
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation
import UIKit

class VIPERWireFrame: VIPERWireFrameProtocol {

    class func createAddContactModule(with delegate: AddModuleDelegate) -> UIViewController {

        let navController = mainStoryboard.instantiateViewControllerWithIdentifier("AddContactsNavigationController")
        if let view = navController.childViewControllers.first as? VIPERViewProtocol {
            // Generating module components
            let presenter: protocol<VIPERPresenterProtocol, VIPERInteractorOutputProtocol> = VIPERPresenter()
            let interactor: VIPERInteractorInputProtocol = VIPERInteractor()
            let localDataManager: VIPERLocalDataManagerInputProtocol = VIPERLocalDataManager()
            let wireFrame: VIPERWireFrameProtocol = VIPERWireFrame()

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
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    }

    func dismissAddContactInterface(from view: VIPERViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismissViewControllerAnimated(true, completion: completion)
        }
    }

}

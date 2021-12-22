//
//  RegAssembly.swift
//  Messenger
//
//  Created by Migel Lestev on 07.12.2021.
//

import Foundation
import UIKit

class RegAssembly: UIViewController {
    
    // MARK: Main Module "Register Assembly"
    class func regModuleBuilder() -> UIViewController {
        let view = RegViewController()
        let observer = FireObserver()
        let interactor = RegInteractor(view: view, observer: observer)
        let router = RegRouter(viewController: view)
        let presenter = RegPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}

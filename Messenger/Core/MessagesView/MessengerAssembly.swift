//
//  MessengerAssembly.swift
//  Messenger
//
//  Created by Migel Lestev on 08.12.2021.
//

import UIKit

class MessengerAssembly: UIViewController {
    class func messengerModuleBuilder() -> UIViewController {
        let view = MessengerViewController()
        let observer = FireObserver()
        let interactor = MessengerInteractor(observer: observer, view: view)
        let router = MessengerRouter(viewController: view)
        let presenter = MessengerPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        observer.messageView = view
        return view
    }
}

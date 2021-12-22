//
//  ChatAssembly.swift
//  Messenger
//
//  Created by Migel Lestev on 20.12.2021.
//

import UIKit

class ChatAssembly: UIViewController {
    class func chatModuleBuilder() -> UIViewController {
        let view = ChatViewController()
        let observer = FireObserver()
        let interactor = ChatInteractor(observer: observer, view: view)
        let router = ChatRouter(viewController: view)
        let presenter = ChatPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        
        return view
    }
}

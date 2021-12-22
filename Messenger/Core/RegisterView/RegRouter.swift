//
//  RegRouter.swift
//  Messenger
//
//  Created by Migel Lestev on 07.12.2021.
//

import Foundation

protocol RegRouting {
    func closeCurrentViewController() -> Void
}

class RegRouter {
    weak var viewController: RegViewController!
    
    init(viewController: RegViewController) {
        self.viewController = viewController
    }
}
extension RegRouter: RegRouting {
    
    // setting to close vc
    func closeCurrentViewController() {
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        viewController.dismiss(animated: true, completion: nil)
        print("was dismiss")
    }
}

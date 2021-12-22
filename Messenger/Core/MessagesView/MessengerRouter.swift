//
//  MessengerRouter.swift
//  Messenger
//
//  Created by Migel Lestev on 08.12.2021.
//

import Foundation
import UIKit

protocol MessengerRouting {
    func getTableView() -> UITableView
    func getUser() -> [User]
}

class MessengerRouter {
    weak var viewController: MessengerViewController!
    
    init(viewController: MessengerViewController) {
        self.viewController = viewController
    }
}

extension MessengerRouter: MessengerRouting {
    
    func getUser() -> [User] {
        return viewController.users
    }
    
    func getTableView() -> UITableView {
        return viewController.tableView
    }
    
}

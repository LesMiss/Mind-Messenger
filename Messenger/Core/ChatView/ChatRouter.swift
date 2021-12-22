//
//  ChatRouter.swift
//  Messenger
//
//  Created by Migel Lestev on 20.12.2021.
//

import UIKit

protocol ChatRouting {

}

class ChatRouter {
    weak var viewController: ChatViewController!
    
    init(viewController: ChatViewController) {
        self.viewController = viewController
    }
}
extension ChatRouter: ChatRouting {
    
}

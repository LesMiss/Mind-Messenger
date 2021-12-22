//
//  ChatPresenter.swift
//  Messenger
//
//  Created by Migel Lestev on 20.12.2021.
//

import Foundation
import MessageKit

protocol ChatPresentation {
    func sendingMessage(user: User, data: String) -> Void
    func extractMessages(id: String, sender: Sender, neededId: String)
}

class ChatPresenter {
    
    weak var view: ChatViewController?
    var interactor: ChatUseCase
    var router: ChatRouting
    
    init(view: ChatViewController, interactor: ChatUseCase, router: ChatRouting) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
}

extension ChatPresenter: ChatPresentation {
    
    func extractMessages(id: String, sender: Sender, neededId: String) {
        interactor.observingMessages(id: id, sender: sender, neededId: neededId) { [ weak self ] message in
            guard let `self` = self else { return }
            guard let message = message else { return }
            self.view?.messages.append(message)
            let sortedArray = self.view?.messages.sorted(by: { $0.timeForSort < $1.timeForSort })
            self.view?.messages = sortedArray ?? []
            self.view?.messageInputBar.inputTextView.text = ""
            self.view?.messagesCollectionView.reloadData()
        }
    }
    
    func sendingMessage(user: User, data: String) {
        interactor.sendMessage(user: user, data: data)
    }
    
}

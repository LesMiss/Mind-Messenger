//
//  ChatInteractor.swift
//  Messenger
//
//  Created by Migel Lestev on 20.12.2021.
//

import Foundation

protocol ChatUseCase {
    func sendMessage(user: User, data: String) -> Void
    func observingMessages(id: String, sender: Sender, neededId: String, completion: @escaping (Message?) -> Void)
}

class ChatInteractor {
    
    var observer: FireObserverProtocol
    weak var view: ChatViewProtocol?
    
    init(observer: FireObserverProtocol, view: ChatViewProtocol) {
        self.view = view
        self.observer = observer
    }
}

extension ChatInteractor: ChatUseCase {
    
    func observingMessages(id: String, sender: Sender, neededId: String, completion: @escaping (Message?) -> Void) {
        observer.observingDataUsers(id: id, sender: sender, neededId: neededId) { message in
            completion(message)
        }
    }
        
    func sendMessage(user: User, data: String) {
        observer.sendMessage(user: user, data: data)
    }
}

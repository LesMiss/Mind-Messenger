//
//  ChatViewController.swift
//  Messenger
//
//  Created by Migel Lestev on 08.12.2021.
//

import UIKit
import MessageKit
import Firebase

protocol ChatViewProtocol: class {

}

class ChatViewController: MessagesViewController {
    
    let currentUser = Sender(senderId: "self", displayName: "Bobby")
    let otherUser = Sender(senderId: "other", displayName: "Sam")
    
    var user: User?
    
    var messages = [MessageType]()
    
    var presenter: ChatPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extractAllMessages()
        self.messagesCollectionView.reloadData()

        messageInputBar.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    // action
    @objc func sendMessage() {
        guard let user = user else { return }
        presenter?.sendingMessage(user: user, data: messageInputBar.inputTextView.text ?? "")
    }
    
    func extractAllMessages() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        self.presenter?.extractMessages(id: user?.id ?? "", sender: otherUser, neededId: id)
        self.presenter?.extractMessages(id: id, sender: currentUser, neededId: user?.id ?? "")
    }
}

extension ChatViewController: ChatViewProtocol {
    
}

extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = self.messages[indexPath.section].date
        return NSAttributedString(string: name, attributes: [ .font: UIFont.preferredFont(forTextStyle: .caption1), .foregroundColor: UIColor(white: 0.3, alpha: 1)])
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }
    
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 1)
    }
}

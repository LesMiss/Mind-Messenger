//
//  Message.swift
//  Messenger
//
//  Created by Migel Lestev on 20.12.2021.
//

import Foundation
import MessageKit

struct Sender: SenderType {
    var senderId: String
    
    var displayName: String
}

struct Message: MessageType {
    
    var timeForSort: String
    
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
    var toId: String
    var fromId: String
    var date: String
}

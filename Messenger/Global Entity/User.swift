//
//  RegModel.swift
//  Messenger
//
//  Created by Migel Lestev on 07.12.2021.
//

import Foundation
import Firebase
import UIKit

struct User {
    var name: String?
    var email: String?
    var id: String?
    var isOnline: Bool?
    var avatar: UIImage?
    
    init(dictionary: [String : Any]) {
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
    }
}

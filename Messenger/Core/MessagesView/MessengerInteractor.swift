//
//  MessengerInteractor.swift
//  Messenger
//
//  Created by Migel Lestev on 08.12.2021.
//

import Foundation
import FirebaseAuth

protocol MessengerUseCase {
    func fetchUsers(completion: @escaping (User) -> Void)
    func signOut()
    func getUserName(completion: @escaping (String?) -> ()) -> Void
    func deleteCurrentUserInTableView(indexPath: IndexPath, completion: @escaping (String?) -> Void)
}

class MessengerInteractor {
    
    var observer: FireObserverProtocol
    weak var view: MessengerViewProtocol?
    
    init(observer: FireObserverProtocol, view: MessengerViewProtocol) {
        self.view = view
        self.observer = observer
    }
}

extension MessengerInteractor: MessengerUseCase {
    
    func deleteCurrentUserInTableView(indexPath: IndexPath, completion: @escaping (String?) -> Void) {
        let id = Auth.auth().currentUser?.uid
        completion(id)
    }
    
    func getUserName(completion: @escaping (String?) -> ()) {
        observer.observingCurrentUserName { user in
            completion(user)
        }
    }
    
    func fetchUsers(completion: @escaping (User) -> Void) {
        observer.fetchUser { user in
            completion(user)
        }
    }
    
    func signOut() {
        observer.signOut()
    }
    
}

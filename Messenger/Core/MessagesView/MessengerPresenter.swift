//
//  MessengerPresenter.swift
//  Messenger
//
//  Created by Migel Lestev on 08.12.2021.
//

import Foundation

protocol MessengerPresentation {
    func extractUsers()
    func signOut()
    func viewDidLoad()
    func deletingCurrentUserInTableView(indexPath: IndexPath, completion: @escaping () -> Void)
    
}

class MessengerPresenter {
    
    weak var view: MessengerViewProtocol?
    var interactor: MessengerUseCase
    var router: MessengerRouting
    
    init(view: MessengerViewProtocol, interactor: MessengerUseCase, router: MessengerRouting) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
}

extension MessengerPresenter: MessengerPresentation {
    
    func viewDidLoad() {
        interactor.getUserName { [ weak self ] name in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.view?.getName(name: name ?? "")
            }
        }
    }
    
    func extractUsers() {
        interactor.fetchUsers { user in
            self.view?.users = self.router.getUser()
            self.view?.users.append(user)
            self.router.getTableView().reloadData()
        }
    }
    
    func signOut() {
        interactor.signOut()
    }
    
    func deletingCurrentUserInTableView(indexPath: IndexPath, completion: @escaping () -> Void) {
        interactor.deleteCurrentUserInTableView(indexPath: indexPath) { id in
            let user = self.view?.users[indexPath.row]
            if id == user?.id {
                self.view?.users.removeAll { $0.id == id }
                completion()
            }
        }
    }
    
}

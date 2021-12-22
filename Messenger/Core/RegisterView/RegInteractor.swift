//
//  RegInteractor.swift
//  Messenger
//
//  Created by Migel Lestev on 07.12.2021.
//

import UIKit

protocol RegUseCase {
    func createAccount(data: Data, email: String, password: String, name: String, completion: @escaping (String) -> Void)
    func signInAccount(email: String, password: String, name: String, completion: @escaping (String) -> Void)
    func allAnimation(index: Int) -> Void
}

class RegInteractor {
    
    weak var view: RegView?
    var observer: FireObserverProtocol
    
    init(view: RegView, observer: FireObserverProtocol) {
        self.view = view
        self.observer = observer
    }
}

extension RegInteractor: RegUseCase {
    
    //MARK: create & sign up accounts ->
    func signInAccount(email: String, password: String, name: String, completion: @escaping (String) -> Void) {
        observer.signIn(email: email, password: password) { errorText in
            completion(errorText)
        }
    }
    
    func createAccount(data: Data, email: String, password: String, name: String, completion: @escaping (String) -> Void) {
        observer.createAccount(data: data, email: email, password: password, name: name) { errorText in
            completion(errorText)
        }
    }
    
    func allAnimation(index: Int) {
        if index == 0 {
            view?.mainView.registerButton.setTitle("Sign In", for: .normal)
            view?.mainView.animateAlphaForAvatar()
            view?.mainView.animateAlphaForNameTextField()
            view?.mainView.animateForEmailTextField()
        } else {
            view?.mainView.registerButton.setTitle("Register", for: .normal)
            view?.mainView.animateAlphaForAvatar(alpha: 1)
            view?.mainView.animateAlphaForNameTextField(alpha: 1)
            view?.mainView.animateForEmailTextField(inset: -40)
        }
    }
}

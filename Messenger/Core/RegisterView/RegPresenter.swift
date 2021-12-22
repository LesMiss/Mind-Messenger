//
//  RegPresenter.swift
//  Messenger
//
//  Created by Migel Lestev on 07.12.2021.
//

import Foundation
import UIKit

protocol RegPresentation: class {
    func getAccounts(email: String, password: String, name: String)
    func allAnimation() -> Void
}

class RegPresenter {
    weak var view: RegView?
    var interactor: RegInteractor
    var router: RegRouting
    init(view: RegView, interactor: RegInteractor, router: RegRouting) {
        self.interactor = interactor
        self.view = view
        self.router = router
    }
    
    fileprivate func handlingError(errorText: String) {
        // first initialize errorLabel
        self.view?.mainView.errorLabel.text = errorText
        
        // if the user was added successfully
        if errorText == "" {
            DispatchQueue.main.async {
                self.router.closeCurrentViewController()
            }
        } // if not ....
        else {
            self.view?.mainView.shakeError()
            self.view?.mainView.spinner.stopAnimating()
            self.view?.mainView.visualEffectView.alpha = 0
        }
    }
}

extension RegPresenter: RegPresentation {
    
    func allAnimation() {
        self.interactor.allAnimation(index: view?.mainView.segmentedControl.selectedSegmentIndex ?? 0)
    }
    
    func getAccounts(email: String, password: String, name: String) {
                
        if view?.mainView.segmentedControl.selectedSegmentIndex == 0 {

            // sign in, if selected element == 0
            interactor.signInAccount(email: email, password: password, name: name) { [weak self] errorText in
                guard let `self` = self else { return }
                self.handlingError(errorText: errorText)
            }
            
        } else {
            
            // create and add photo, if selected element == 1
            guard let data = self.view?.mainView.avatar.image?.jpegData(compressionQuality: 0.4) else {
                DispatchQueue.main.async {
                    // stopping to load
                    self.view?.mainView.spinner.stopAnimating()
                    self.view?.mainView.visualEffectView.alpha = 0
                }
                
                // showing animation error
                view?.mainView.avatar.layer.borderWidth = 1
                view?.mainView.avatar.layer.borderColor = UIColor.red.cgColor
                view?.mainView.shake()
                return
            }
            
            // if avatar was selected ....
            interactor.createAccount(data: data, email: email, password: password, name: name) { [weak self] errorText in
                guard let `self` = self else { return }
                self.handlingError(errorText: errorText)
            }
        }
    }
    
}

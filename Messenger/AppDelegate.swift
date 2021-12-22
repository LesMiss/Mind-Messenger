//
//  AppDelegate.swift
//  Messenger
//
//  Created by Migel Lestev on 07.12.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let `self` = self else { return }
            if user == nil {
                self.showModalWindowSignUp()
            } else {
                return
            }
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = UINavigationController(rootViewController: MessengerAssembly.messengerModuleBuilder())
        window?.makeKeyAndVisible()
        
        return true
    }
    
    //MARK: Show modal Sign Up View
    func showModalWindowSignUp() {
        let regView = RegAssembly.regModuleBuilder()
        regView.modalPresentationStyle = .fullScreen
        window?.rootViewController?.present(regView, animated: false, completion: nil)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
}


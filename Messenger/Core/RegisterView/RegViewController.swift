//
//  ViewController.swift
//  Messenger
//
//  Created by Migel Lestev on 07.12.2021.
//

import UIKit
import FirebaseStorage

protocol RegView: class {
    var segmentIndex: Int { get set }
    var isHidden: Bool { get set }
    var mainView: Container { get }
}

class RegViewController: UIViewController {
    
    // properties
    var segmentIndex: Int = 1
    var isHidden: Bool = true

    var mainView: Container { return self.view as! Container }
    var presenter: RegPresentation?
    
    //override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tappingOnAvatar()
        self.configureView()
    }
    
    override func loadView() {
        self.view = Container(frame: UIScreen.main.bounds)
    }
    
    //MARK: func response from the presenter
    func configureView() {
        //1. action for segmentControl
        mainView.segmentClosure = { [weak self] in
            guard let `self` = self else { return }
            self.presenter?.allAnimation()
        }
        
        //2. action for button
        mainView.regButtonClosure = {
            
            // start animating to load
            self.mainView.loadAnimation()
            
            // add user in tableView
            self.presenter?.getAccounts(
                email: self.mainView.emailTextField.text ?? "",
                password: self.mainView.passwordTextField.text ?? "",
                name: self.mainView.nameTextField.text ?? ""
            )}
    }
    
    //MARK: handling touch on avatar
    func tappingOnAvatar() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        mainView.avatar.addGestureRecognizer(tapGR)
        mainView.avatar.isUserInteractionEnabled = true
    }
    
    @objc func imageTapped() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.isEditing = true
        present(vc, animated: true)
    }
    
}

extension RegViewController: RegView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        mainView.avatar.image = image
        picker.dismiss(animated: true)
        
        // animation tf + img
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.mainView.avatar.layer.borderColor = #colorLiteral(red: 0.07052930444, green: 0.6548408866, blue: 0.2236400247, alpha: 1).cgColor
            self.mainView.animateForNameTextField()
            self.mainView.animateHeightAvatar()
        }
    }
}

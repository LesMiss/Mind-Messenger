//
//  Conteiner + ext.swift
//  Messenger
//
//  Created by Migel Lestev on 07.12.2021.
//

import UIKit
import SnapKit

extension Container {
    
    func configureView() {
        
        //MARK: add scroll view in view
        addSubview(scrollView)
        scrollView.frame = bounds
        scrollView.backgroundColor = .systemBackground
        scrollView.contentSize.height = frame.height + 50
        scrollView.isScrollEnabled = true
        
        
        //MARK: add UI Elements
        // images
        scrollView.addSubview(logo)
        scrollView.addSubview(avatar)
        
        // text
        scrollView.addSubview(title)
        scrollView.addSubview(bottomDescription)
        
        // text fields
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)

        // other
        scrollView.addSubview(registerButton)
        scrollView.addSubview(segmentedControl)
        scrollView.addSubview(errorLabel)

        // spinner + blur effect
        scrollView.addSubview(visualEffectView)
        scrollView.addSubview(spinner)
        
        //MARK: constraints
        logo.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(50)
            make.width.equalTo(62)
            make.height.equalTo(62)
        }
        title.snp.makeConstraints { make in
            make.left.equalTo(logo.snp.right).inset(-10)
            make.top.equalTo(logo.snp.top)
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
        bottomDescription.snp.makeConstraints { make in
            make.left.equalTo(logo.snp.right).inset(-10)
            make.top.equalTo(title.snp.bottom).inset(15)
            make.height.equalTo(50)
            make.width.equalTo(220)
        }
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(bottomDescription.snp.bottom).inset(-5)
            make.left.equalTo(20)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(50)
        }
        avatar.snp.makeConstraints { make in
            make.left.equalTo(segmentedControl.snp.right).inset(-10)
            self.avatarWidthYconstraint = make.top.equalTo(bottomDescription.snp.bottom).inset(-5).constraint
            self.avatarHeightConstraint = make.height.equalTo(50).constraint
            make.width.equalTo(82)
        }
        nameTextField.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(segmentedControl.snp.bottom).inset(-10)
            self.nameTextFieldWidthConstraint = make.width.equalToSuperview().multipliedBy(0.8).constraint
            make.height.equalTo(50)
        }
        emailTextField.snp.makeConstraints { make in
            make.left.equalTo(20)
            self.emailTextFieldYConstraint = make.top.equalTo(nameTextField.snp.bottom).inset(-35).constraint
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints { make in
            make.left.equalTo(20)
            self.passwordTextFieldYConstraint = make.top.equalTo(emailTextField.snp.bottom).inset(-10).constraint
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }
        errorLabel.snp.makeConstraints { make in
            make.left.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).inset(-2)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        registerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(errorLabel.snp.bottom).inset(-5)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(50)
        }
        spinner.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(62)
            make.height.equalTo(62)
        }        
    }
}

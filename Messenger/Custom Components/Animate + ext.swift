//
//  Animate + ext.swift
//  Messenger
//
//  Created by Migel Lestev on 16.12.2021.
//

import UIKit

extension Container {
    
    //MARK: All animstions ->
    
    // alpha animate
    func animateAlphaForAvatar(alpha: CGFloat = 0) {
        UIImageView.animate(withDuration: 0.3) {
            self.nameTextField.alpha = alpha
        }
    }
    func animateAlphaForNameTextField(alpha: CGFloat = 0) {
        UITextField.animate(withDuration: 0.3) {
            self.avatar.alpha = alpha
        }
    }
    
    // lifting animation ->
    func animateForNameTextField() {
        UITextField.animate(withDuration: 0.7, delay: 0.4, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.nameTextFieldWidthConstraint?.update(inset: 40)
            self.layoutIfNeeded()
            
        })
    }
    func animateForEmailTextField(inset: CGFloat = 40) {
        UITextField.animate(withDuration: 1, delay: 0.1, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.emailTextFieldYConstraint?.update(inset: inset)
            self.layoutIfNeeded()
        })
    }
    
    // load ....
    func loadAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIView.animate(withDuration: 0.5) {
                self.visualEffectView.alpha = 1
            }
            self.spinner.startAnimating()
        }
    }
    
    // custom animate
    func animateHeightAvatar() {
        UIImageView.animate(withDuration: 0.7, delay: 0.2, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.avatarHeightConstraint?.update(inset: -42)
            self.avatar.layer.cornerRadius = self.avatar.bounds.width / 2
            self.layoutIfNeeded()
        })
    }
    
    // shake animation ->
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    func shakeError() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        errorLabel.layer.add(animation, forKey: "shake")
    }
}

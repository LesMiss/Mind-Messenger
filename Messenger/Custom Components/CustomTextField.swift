//
//  CustomTextField.swift
//  Messenger
//
//  Created by Migel Lestev on 16.12.2021.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String, secure: Bool = false, color: UIColor = .secondarySystemBackground, keyboardType: UIKeyboardType) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        isSecureTextEntry = secure
        layer.cornerRadius = 10
        backgroundColor = color
        autocapitalizationType = .none
        self.textContentType = .oneTimeCode
        self.keyboardType = keyboardType
        autocorrectionType = .no

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

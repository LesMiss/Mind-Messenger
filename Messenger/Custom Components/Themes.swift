//
//  Themes.swift
//  Messenger
//
//  Created by Migel Lestev on 12.12.2021.
//

import Foundation
import UIKit

extension UIColor {
    static var dynamic = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .light {
            return .black
        } else {
            return .white
        }
    }
        
}

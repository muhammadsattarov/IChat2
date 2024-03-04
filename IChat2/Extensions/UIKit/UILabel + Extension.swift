//
//  UILabel + Extension.swift
//  IChat2
//
//  Created by user on 20/02/24.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont? = .apple20()) {
        self.init()
        self.text = text
        self.font = font
    }
}

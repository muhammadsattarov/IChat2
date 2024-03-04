//
//  UIImageView + Extension.swift
//  IChat2
//
//  Created by user on 20/02/24.
//

import UIKit

extension UIImageView {

    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        self.image = image
        self.contentMode = contentMode
    }
}

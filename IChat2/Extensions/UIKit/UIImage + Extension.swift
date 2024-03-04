//
//  UIImage + Extension.swift
//  IChat2
//
//  Created by user on 28/02/24.
//

import UIKit

extension UIImage {
    var scaledToSafeUPloadSize: UIImage? {
        let maximageSideLength: CGFloat = 480
    
        let largeSize: CGFloat = max(size.width, size.height)
        let radioScale: CGFloat = largeSize > maximageSideLength ? largeSize / maximageSideLength : 1
        let newImageSize = CGSize(width: size.width / radioScale, height: size.height / radioScale)
        
        return image(scaledTo: newImageSize)
    }
    func image(scaledTo size: CGSize) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(in: CGRect(origin: .zero, size: size))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

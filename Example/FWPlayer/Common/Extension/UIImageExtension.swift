//
//  UIImageExtension.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-05.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

extension UIImage {
    
    func scaleToSize(size: CGSize) -> UIImage {
        if self.size.equalTo(size) {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}

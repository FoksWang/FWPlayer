//
//  FWScrollView.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-07.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class FWScrollView: UIScrollView, UIScrollViewDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
    }
}

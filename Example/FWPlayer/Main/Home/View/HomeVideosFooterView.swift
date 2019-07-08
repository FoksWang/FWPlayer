//
//  HomeVideosFooterView.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-08.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class HomeVideosFooterView: UICollectionReusableView {
    static let className = "HomeVideosFooterView"
    static let reuseIdentifier = className
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {}
}

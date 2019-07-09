//
//  DetailsViewModel.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-08.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class DetailsViewModel {
    private var currentIndex: Int = 0
    var videoList = [VideoModel]()
    
    init(currentIndex: Int, videoList: [VideoModel]) {
        self.currentIndex = currentIndex
        self.videoList = videoList
    }
}

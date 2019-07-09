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
    private var videoList = [VideoModel]()
    
    init(currentIndex: Int, videoList: [VideoModel]) {
        self.currentIndex = currentIndex
        self.videoList = videoList
    }
    
    // Mark: - Data Source
    typealias AddDataBlock = ([URL]) -> Void
    var updateDataBlock: AddDataBlock?
}

// Mark: - Data Handling
extension DetailsViewModel {
    func loadData() {
        var videoUrls = [URL]()
        for videoModel in videoList {
            if videoModel.type == "local" {
                videoUrls.append(URL(fileURLWithPath: videoModel.videoUrl!))
            } else {
                videoUrls.append(URL(string: videoModel.videoUrl!)!)
            }
        }
        let videoModel = videoUrls.remove(at: self.currentIndex)
        videoUrls.insert(videoModel, at: 0)
        
        self.updateDataBlock?(videoUrls)
    }
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension DetailsViewModel {
    func numberOfRowsInSection(section: Int) -> Int {
        return videoList.count
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 { // top cell
            return 650
            
//        } else { // bottom cells
//            return 400
//        }
    }
}

// MARK:- Others
extension DetailsViewModel {
    /// Check if the video needs feature 'Media Cache'
    ///
    /// - Returns: return a video type of the video list
    func isTypeAssets() -> Bool {
        if let type = videoList[currentIndex].type, type == "asset" {
            return true
        }
        return false
    }
    
    func getVideoModel(indexPath: IndexPath) -> VideoModel {
        return videoList[indexPath.row]
    }
}

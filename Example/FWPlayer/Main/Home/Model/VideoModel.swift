//
//  VideoModel.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-06.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import HandyJSON

// outer app model
struct HomeVideoList {
    var videos = [String: [VideoModel]]()
    var displayIndex = ["local", "swedish", "live", "vod", "media"]
}

// inner http model
struct VideoListModel: HandyJSON {
    var swedish: [VideoModel]?
    var live: [VideoModel]?
    var vod: [VideoModel]?
    var media: [VideoModel]?
}

struct VideoModel: HandyJSON {
    var description: String?
    var imageUrl: String?
    var title: String?
    var type: String?
    var videoUrl: String?
}

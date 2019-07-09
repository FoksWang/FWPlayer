//
//  HomeViewModel.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-05.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import HandyJSON

class HomeViewModel {
    
    // MARK - Data Model
    var homeVideoList = HomeVideoList()
    private lazy var localVideoList: [VideoModel] = {
        var list = [VideoModel]()
        
        var video01 = VideoModel()
        video01.description = "Simba idolizes his father, King Mufasa, and takes to heart his own royal destiny on the plains of Africa. But not everyone in the kingdom celebrates the new cub's arrival. Scar, Mufasa's brother -- and former heir to the throne -- has plans of his own. The battle for Pride Rock is soon ravaged with betrayal, tragedy and drama, ultimately resulting in Simba's exile. Now, with help from a curious pair of newfound friends, Simba must figure out how to grow up and take back what is rightfully his."
        video01.imageUrl = "trailer_image_lion"
        video01.title = "The Lion King"
        video01.type = "local"
        video01.videoUrl = Bundle.main.path(forResource: "trailer_lion.mp4", ofType: nil)
        
        var video02 = VideoModel()
        video02.description = "Red, Chuck, Bomb and the rest of their feathered friends are surprised when a green pig suggests that they put aside their differences and unite to fight a common threat. Aggressive birds from an island covered in ice are planning to use an elaborate weapon to destroy the fowl and swine way of life. After picking their best and brightest, the birds and pigs come up with a scheme to infiltrate the island, deactivate the device and return to their respective paradises intact."
        video02.imageUrl = "trailer_image_birds"
        video02.title = "The Angry Birds Movie 2"
        video02.type = "local"
        video02.videoUrl = Bundle.main.path(forResource: "trailer_birds.mp4", ofType: nil)
        
        var video03 = VideoModel()
        video03.description = "Adrift in space with no food or water, Tony Stark sends a message to Pepper Potts as his oxygen supply starts to dwindle. Meanwhile, the remaining Avengers -- Thor, Black Widow, Captain America and Bruce Banner -- must figure out a way to bring back their vanquished allies for an epic showdown with Thanos -- the evil demigod who decimated the planet and the universe."
        video03.imageUrl = "trailer_image_avengers"
        video03.title = "Avengers: Endgame"
        video03.type = "local"
        video03.videoUrl = Bundle.main.path(forResource: "trailer_avengers.mp4", ofType: nil)
        
        var video04 = VideoModel()
        video04.description = "A man journeys across a lawless solar system to find his missing father -- a renegade scientist who poses a threat to humanity."
        video04.imageUrl = "trailer_image_astra"
        video04.title = "Ad Astra"
        video04.type = "local"
        video04.videoUrl = Bundle.main.path(forResource: "trailer_astra.mp4", ofType: nil)
        
        list.append(video01)
        list.append(video02)
        list.append(video03)
        list.append(video04)
        
        return list
    }()
    
    // Mark: - Data Source
    typealias AddDataBlock = () -> Void
    var updateDataBlock: AddDataBlock?
}

// Mark: - Data Handling
extension HomeViewModel {
    func loadData() {
        HomeVideosProvider.request(.getVideos) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let _ = JSONDeserializer<VideoListModel>.deserializeFrom(json: json.description) {
                    
                    self.homeVideoList.videos.removeAll()
                    self.homeVideoList.videos["local"] = self.localVideoList
                    
                    if let swedishVideoList = JSONDeserializer<VideoModel>.deserializeModelArrayFrom(json: json["swedish"].description) {
                        self.homeVideoList.videos["swedish"] = swedishVideoList as? [VideoModel]
                    }
                    
                    if let liveVideoList = JSONDeserializer<VideoModel>.deserializeModelArrayFrom(json: json["live"].description) {
                        self.homeVideoList.videos["live"] = liveVideoList as? [VideoModel]
                    }
                    
                    if let vodVideoList = JSONDeserializer<VideoModel>.deserializeModelArrayFrom(json: json["vod"].description) {
                        self.homeVideoList.videos["vod"] = vodVideoList as? [VideoModel]
                    }
                    
                    if let mediaVideoList = JSONDeserializer<VideoModel>.deserializeModelArrayFrom(json: json["media"].description) {
                        self.homeVideoList.videos["media"] = mediaVideoList as? [VideoModel]
                    }
                    
                    self.updateDataBlock?()
                }
            }
        }
    }
}

// MARK:- UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate
extension HomeViewModel {
    func numberOfSections(collectionView: UICollectionView) -> Int {
        return homeVideoList.videos.count
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return 1
    }
    
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func minimumInteritemSpacingForSectionAt(section: Int) -> CGFloat {
        return 0
    }
    
    func minimumLineSpacingForSectionAt(section: Int) -> CGFloat {
        return 0
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        let key = homeVideoList.displayIndex[indexPath.section]
        let moduleType = homeVideoList.videos[key]?.first?.type
        if moduleType == "local" {
            return CGSize(width: fwScreenWidth, height: fwScreenWidth * 9 / 16)
        } else {
            return CGSize(width: fwScreenWidth, height: 200)
        }
    }
    
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        let key = homeVideoList.displayIndex[section]
        let moduleType = homeVideoList.videos[key]?.first?.type
        if moduleType == "local" {
            return CGSize.zero
        } else {
            return CGSize(width: fwScreenWidth, height: 55)
        }
    }
    
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func viewForSupplementaryElementOfKind(_ collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        let key = homeVideoList.displayIndex[indexPath.section]
//        let moduleType = homeVideoList.videos[key]?.first?.type
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeVideosHeaderView.reuseIdentifier, for: indexPath) as! HomeVideosHeaderView
            headerView.videoList = homeVideoList.videos[key]
            headerView.headerViewClick = { (videoList) in
                NotificationCenter.default.post(name: notificationNameShowMessage, object: "No such function at the moment")
            }
            return headerView
            
        } else if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeVideosFooterView.reuseIdentifier, for: indexPath) as! HomeVideosFooterView
            return footerView
            
        } else {
            return UICollectionReusableView()
        }
    }
}

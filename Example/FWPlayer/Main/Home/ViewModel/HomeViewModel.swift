//
//  HomeViewModel.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-05.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

class HomeViewModel: NSObject {
    
    // MARK - Data Model
    lazy var cyclePagerArray: [VideoModel] = {
        var data = [VideoModel]()
        
        var video01 = VideoModel()
        video01.description = "Simba idolizes his father, King Mufasa, and takes to heart his own royal destiny on the plains of Africa. But not everyone in the kingdom celebrates the new cub's arrival. Scar, Mufasa's brother -- and former heir to the throne -- has plans of his own. The battle for Pride Rock is soon ravaged with betrayal, tragedy and drama, ultimately resulting in Simba's exile. Now, with help from a curious pair of newfound friends, Simba must figure out how to grow up and take back what is rightfully his."
        video01.imageUrl = "trailer_image_lion"
        video01.title = "The Lion King"
        video01.type = "Local"
        video01.videoUrl = Bundle.main.path(forResource: "trailer_lion.mp4", ofType: nil)
        
        var video02 = VideoModel()
        video02.description = "Red, Chuck, Bomb and the rest of their feathered friends are surprised when a green pig suggests that they put aside their differences and unite to fight a common threat. Aggressive birds from an island covered in ice are planning to use an elaborate weapon to destroy the fowl and swine way of life. After picking their best and brightest, the birds and pigs come up with a scheme to infiltrate the island, deactivate the device and return to their respective paradises intact."
        video02.imageUrl = "trailer_image_birds"
        video02.title = "The Angry Birds Movie 2"
        video02.type = "Local"
        video02.videoUrl = Bundle.main.path(forResource: "trailer_birds.mp4", ofType: nil)
        
        var video03 = VideoModel()
        video03.description = "Adrift in space with no food or water, Tony Stark sends a message to Pepper Potts as his oxygen supply starts to dwindle. Meanwhile, the remaining Avengers -- Thor, Black Widow, Captain America and Bruce Banner -- must figure out a way to bring back their vanquished allies for an epic showdown with Thanos -- the evil demigod who decimated the planet and the universe."
        video03.imageUrl = "trailer_image_avengers"
        video03.title = "Avengers: Endgame"
        video03.type = "Local"
        video03.videoUrl = Bundle.main.path(forResource: "trailer_avengers.mp4", ofType: nil)
        
        var video04 = VideoModel()
        video04.description = "A man journeys across a lawless solar system to find his missing father -- a renegade scientist who poses a threat to humanity."
        video04.imageUrl = "trailer_image_astra"
        video04.title = "Ad Astra"
        video04.type = "Local"
        video04.videoUrl = Bundle.main.path(forResource: "trailer_astra.mp4", ofType: nil)
        
        data.append(video01)
        data.append(video02)
        data.append(video03)
        data.append(video04)
        
        return data
    }()
    
    // Mark: - Data Source
    typealias AddDataBlock = () -> Void
    var updateDataBlock: AddDataBlock?
}

// Mark: - Data Handling
extension HomeViewModel {
    func setupData() {
    }
}

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
    
    // Mark: - Data Source
    typealias AddDataBlock = () -> Void
    var updateDataBlock: AddDataBlock?
}

// Mark: - Data Handling
extension HomeViewModel {
    func setupData() {
    }
}

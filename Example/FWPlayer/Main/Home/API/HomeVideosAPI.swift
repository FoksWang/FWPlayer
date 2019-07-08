//
//  HomeVideosAPI.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-07.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

let HomeVideosProvider = MoyaProvider<HomeVideosAPI>()

enum HomeVideosAPI {
    case getVideos
}

extension HomeVideosAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://fwplayer-example.firebaseio.com")!
    }
    
    var path: String {
        switch self {
            case .getVideos: return "/getVideos.json"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        let parmeters: [String: Any] = [:]
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}

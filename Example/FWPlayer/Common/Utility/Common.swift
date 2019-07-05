//
//  Common.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-05.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

func Logging<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("\(fileName):(\(lineNum))-\(message)")
    #endif
}

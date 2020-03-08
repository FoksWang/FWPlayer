//
//  UITableViewExtension.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2020-03-08.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

extension UITableView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() }) { _ in
            completion()
        }
    }
}

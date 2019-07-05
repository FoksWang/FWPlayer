//
//  AboutViewController.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-04.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    
    private lazy var webView: WKWebView = {
        return WKWebView(frame: self.view.bounds)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(webView)
        webView.load(URLRequest(url: URL(string: "https://fokswang.wixsite.com/home")!))
    }
    
}

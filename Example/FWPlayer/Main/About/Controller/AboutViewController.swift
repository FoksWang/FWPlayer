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
    
    private lazy var leftBarButton = UIButton(type: .custom).then {
        let itemSize = 20
        let lightImage = UIImage(named: "navigation_drawer_dark")!
        let darkImage = UIImage(named: "navigation_drawer_light")!
        let image = UIImage(.dm, light: lightImage, dark: darkImage)
        $0.setImage(image.scaleToSize(size: CGSize(width: itemSize, height: itemSize)), for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: itemSize, height: itemSize)
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        $0.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.sideMenuController?.revealMenu()
        }).disposed(by: rx.disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        self.view.addSubview(webView)
        webView.load(URLRequest(url: URL(string: "https://fokswang.wixsite.com/home")!))
    }
    
}

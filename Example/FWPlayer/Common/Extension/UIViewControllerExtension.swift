//
//  UIViewControllerExtension.swift
//  FWPlayer_Example
//
//  Created by Hui Wang on 2019-07-08.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import SwiftMessages

// MARK:- NotificationCenter
extension UIViewController {
    func setupShowMessage() {
        NotificationCenter.default.rx
            .notification(notificationNameShowMessage)
            .subscribe(onNext:{ [weak self] notification in
                guard let self = self else { return }
                if let message = notification.object as? String {
                    self.showMessageView(title: "Message", message: message)
                }
            }).disposed(by: rx.disposeBag)
    }
    
    private func showMessageView(title: String, message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let view = MessageView.viewFromNib(layout: .cardView).then {
                $0.configureTheme(.warning)
                $0.configureDropShadow()
                $0.configureContent(title: title, body: message, iconText: "🦊")
                $0.button?.isHidden = true
            }
            
            var config = SwiftMessages.Config()
            config.presentationContext = .window(windowLevel: .statusBar)
            SwiftMessages.show(config: config, view: view)
        }
    }
}

//
//  FWFloatView.h
//  FWPlayerCore
//
//  Created by Hui Wang on 2019-06-26.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FWFloatView : UIView

/// The parent View
@property(nonatomic, weak) UIView *parentView;

/// Safe margins, mainly for those with Navbar and tabbar
@property(nonatomic, assign) UIEdgeInsets safeInsets;

@end

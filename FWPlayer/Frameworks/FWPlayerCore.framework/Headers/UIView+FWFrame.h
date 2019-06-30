//
//  UIView+FWFrame.h
//  FWPlayerCore
//
//  Created by Hui Wang on 2019-06-27.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FWFrame)

@property (nonatomic) CGFloat fw_x;
@property (nonatomic) CGFloat fw_y;
@property (nonatomic) CGFloat fw_width;
@property (nonatomic) CGFloat fw_height;

@property (nonatomic) CGFloat fw_top;
@property (nonatomic) CGFloat fw_bottom;
@property (nonatomic) CGFloat fw_left;
@property (nonatomic) CGFloat fw_right;

@property (nonatomic) CGFloat fw_centerX;
@property (nonatomic) CGFloat fw_centerY;

@property (nonatomic) CGPoint fw_origin;
@property (nonatomic) CGSize  fw_size;

@end

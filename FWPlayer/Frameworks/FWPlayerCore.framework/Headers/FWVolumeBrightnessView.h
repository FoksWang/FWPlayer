//
//  FWVolumeBrightnessView.h
//  FWPlayerCore
//
//  Created by Hui Wang on 2019-06-27.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FWVolumeBrightnessType) {
    FWVolumeBrightnessTypeVolume,       // volume
    FWVolumeBrightnessTypeumeBrightness // brightness
};

@interface FWVolumeBrightnessView : UIView

@property (nonatomic, assign, readonly) FWVolumeBrightnessType volumeBrightnessType;
@property (nonatomic, strong, readonly) UIProgressView *progressView;
@property (nonatomic, strong, readonly) UIImageView *iconImageView;

- (void)updateProgress:(CGFloat)progress withVolumeBrightnessType:(FWVolumeBrightnessType)volumeBrightnessType;

/// Add system volume view
- (void)addSystemVolumeView;

/// Remove system volume view
- (void)removeSystemVolumeView;

@end

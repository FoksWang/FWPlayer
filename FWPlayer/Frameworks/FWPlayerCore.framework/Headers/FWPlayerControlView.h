//
//  FWPlayerControlView.h
//  FWPlayerCore
//
//  Created by Hui Wang on 2019-06-27.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWPortraitControlView.h"
#import "FWLandScapeControlView.h"
#import "FWPlayerMediaControl.h"
#import "FWSpeedLoadingView.h"
#import "FWSmallFloatControlView.h"

@interface FWPlayerControlView : UIView <FWPlayerMediaControl>

/// View of portrait mode control layer
@property (nonatomic, strong, readonly) FWPortraitControlView *portraitControlView;

/// View of landscape mode control layer
@property (nonatomic, strong, readonly) FWLandScapeControlView *landScapeControlView;

/// Loading
@property (nonatomic, strong, readonly) FWSpeedLoadingView *activity;

/// Fast forward and rewind View
@property (nonatomic, strong, readonly) UIView *fastView;

/// Fast forward fast rewind progress
@property (nonatomic, strong, readonly) FWSliderView *fastProgressView;

/// Fast forward and rewind time
@property (nonatomic, strong, readonly) UILabel *fastTimeLabel;

/// Fast forward and rewind ImageView
@property (nonatomic, strong, readonly) UIImageView *fastImageView;

/// Load failed button
@property (nonatomic, strong, readonly) UIButton *failBtn;

/// Bottom playback progress
@property (nonatomic, strong, readonly) FWSliderView *bottomPgrogress;

/// cover image
@property (nonatomic, strong, readonly) UIImageView *coverImageView;

/// Gaussian blurred background image
@property (nonatomic, strong, readonly) UIImageView *bgImgView;

/// Gaussian blur view
@property (nonatomic, strong, readonly) UIView *effectView;

/// Small float view control layer
@property (nonatomic, strong, readonly) FWSmallFloatControlView *floatControlView;

/// Whether fast-forward view shows animation, the default is NO.
@property (nonatomic, assign) BOOL fastViewAnimated;

/// Whether the area outside the video is displayed with Gaussian blur. The default is YES.
@property (nonatomic, assign) BOOL effectViewShow;

/// Enter full screen mode directly, only full screen mode is supported
@property (nonatomic, assign) BOOL fullScreenOnly;

/// If it is paused, whether to play after seek, the default is YES
@property (nonatomic, assign) BOOL seekToPlay;

/// Back button click callback
@property (nonatomic, copy) void(^backBtnClickCallback)(void);

/// Show or hide the control layer
@property (nonatomic, readonly) BOOL controlViewAppeared;

/// Control layer show or hide callback
@property (nonatomic, copy) void(^controlViewAppearedCallback)(BOOL appeared);

/// Control layer auto hide time, default 2.5 seconds
@property (nonatomic, assign) NSTimeInterval autoHiddenTimeInterval;

/// Control layer show and hide the duration of the animation, the default is 0.25 seconds
@property (nonatomic, assign) NSTimeInterval autoFadeTimeInterval;

/// Slide horizontally to control whether the control layer is displayed during playback progress.The default is YES.
@property (nonatomic, assign) BOOL horizontalPanShowControlView;

/// Whether to display the control layer during prepare.The default is NO.
@property (nonatomic, assign) BOOL prepareShowControlView;

/// Whether loading is displayed during prepare, the default is NO.
@property (nonatomic, assign) BOOL prepareShowLoading;

/// Whether to customize the prohibition of pan gestures. The default is NO.
@property (nonatomic, assign) BOOL customDisablePanMovingDirection;

/**
 Set title, cover, full screen mode

 @param title Video title
 @param coverUrl Video cover, placeholder is gray by default
 @param fullScreenMode Full screen mode
 */
- (void)showTitle:(NSString *)title coverURLString:(NSString *)coverUrl fullScreenMode:(FWFullScreenMode)fullScreenMode;

/**
 Set title, cover, default placeholder image, full screen mode

 @param title Video title
 @param coverUrl Video cover
 @param placeholder Specify a placeholder for the cover
 @param fullScreenMode Full screen mode
 */
- (void)showTitle:(NSString *)title coverURLString:(NSString *)coverUrl placeholderImage:(UIImage *)placeholder fullScreenMode:(FWFullScreenMode)fullScreenMode;

/**
 Set title, UIImage cover, full screen mode

 @param title Video title
 @param image Video cover UIImage
 @param fullScreenMode Full screen mode
 */
- (void)showTitle:(NSString *)title coverImage:(UIImage *)image fullScreenMode:(FWFullScreenMode)fullScreenMode;

/**
 Reset control layer
 */
- (void)resetControlView;

@end

//
//  FWPortraitControlView.h
//  FWPlayerCore
//
//  Created by Hui Wang on 2019-06-27.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import "FWPlayerController.h"
#import "FWSliderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWPortraitControlView : UIView

/// Bottom toolbar
@property (nonatomic, strong, readonly) UIView *bottomToolView;

/// Top toolbar
@property (nonatomic, strong, readonly) UIView *topToolView;

/// title
@property (nonatomic, strong, readonly) UILabel *titleLabel;

/// Play or pause button
@property (nonatomic, strong, readonly) UIButton *playOrPauseBtn;

/// Current playing time
@property (nonatomic, strong, readonly) UILabel *currentTimeLabel;

/// Slider
@property (nonatomic, strong, readonly) FWSliderView *slider;

/// Total video time
@property (nonatomic, strong, readonly) UILabel *totalTimeLabel;

/// Full screen button
@property (nonatomic, strong, readonly) UIButton *fullScreenBtn;

/// player
@property (nonatomic, weak) FWPlayerController *player;

/// sliding
@property (nonatomic, copy, nullable) void(^sliderValueChanging)(CGFloat value,BOOL forward);

/// slider ends
@property (nonatomic, copy, nullable) void(^sliderValueChanged)(CGFloat value);

/// If it is paused, whether to play after seek, the default is YES
@property (nonatomic, assign) BOOL seekToPlay;

/// Reset control layer
- (void)resetControlView;

/// Display control layer
- (void)showControlView;

/// Hide control layer
- (void)hideControlView;

/// Set playback time
- (void)videoPlayer:(FWPlayerController *)videoPlayer currentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime;

/// Set buffer time
- (void)videoPlayer:(FWPlayerController *)videoPlayer bufferTime:(NSTimeInterval)bufferTime;

/// Whether to respond to the gesture
- (BOOL)shouldResponseGestureWithPoint:(CGPoint)point withGestureType:(FWPlayerGestureType)type touch:(nonnull UITouch *)touch;

/// Title and full screen mode
- (void)showTitle:(NSString *_Nullable)title fullScreenMode:(FWFullScreenMode)fullScreenMode;

/// Reverse according to the current playback status
- (void)playOrPause;

/// Play button status
- (void)playBtnSelectedState:(BOOL)selected;

/// Adjust playback progress slider and current time update
- (void)sliderValueChanged:(CGFloat)value currentTimeString:(NSString *)timeString;

/// Slider ends sliding
- (void)sliderChangeEnded;

@end

NS_ASSUME_NONNULL_END

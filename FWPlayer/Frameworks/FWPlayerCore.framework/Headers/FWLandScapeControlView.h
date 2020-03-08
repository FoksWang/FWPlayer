//
//  FWLandScapeControlView.h
//  FWPlayerCore
//
//  Created by Hui Wang on 2019-06-27.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWPlayerController.h"
#import "FWSliderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FWLandScapeControlView : UIView

/// Top toolbar
@property (nonatomic, strong, readonly) UIView *topToolView;

/// Back button
@property (nonatomic, strong, readonly) UIButton *backBtn;

/// title
@property (nonatomic, strong, readonly) UILabel *titleLabel;

/// Bottom toolbar
@property (nonatomic, strong, readonly) UIView *bottomToolView;

/// Play or pause button
@property (nonatomic, strong, readonly) UIButton *playOrPauseBtn;

/// Current playing time
@property (nonatomic, strong, readonly) UILabel *currentTimeLabel;

/// Slider
@property (nonatomic, strong, readonly) FWSliderView *slider;

/// Total video time
@property (nonatomic, strong, readonly) UILabel *totalTimeLabel;

/// Lock screen button
@property (nonatomic, strong, readonly) UIButton *lockBtn;

/// player
@property (nonatomic, weak) FWPlayerController *player;

/// sliding
@property (nonatomic, copy, nullable) void(^sliderValueChanging)(CGFloat value,BOOL forward);

/// slider ends
@property (nonatomic, copy, nullable) void(^sliderValueChanged)(CGFloat value);

/// Back button click callback
@property (nonatomic, copy) void(^backBtnClickCallback)(void);

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

/// Video size changes
- (void)videoPlayer:(FWPlayerController *)videoPlayer presentationSizeChanged:(CGSize)size;

/// Title and full screen mode
- (void)showTitle:(NSString *_Nullable)title fullScreenMode:(FWFullScreenMode)fullScreenMode;

/// Switch status according to the current playback
- (void)playOrPause;

/// Play button status
- (void)playBtnSelectedState:(BOOL)selected;

/// Adjust playback progress slider and current time update
- (void)sliderValueChanged:(CGFloat)value currentTimeString:(NSString *)timeString;

/// Slider ends sliding
- (void)sliderChangeEnded;

@end

NS_ASSUME_NONNULL_END

//
//  FWSliderView.h
//  FWPlayerCore
//
//  Created by Hui Wang on 2019-06-27.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FWSliderViewDelegate <NSObject>

@optional
// Slider start
- (void)sliderTouchBegan:(float)value;
// Slider sliding
- (void)sliderValueChanged:(float)value;
// Slider ends
- (void)sliderTouchEnded:(float)value;
// Slider click
- (void)sliderTapped:(float)value;

@end

@interface FWSliderButton : UIButton

@end

@interface FWSliderView : UIView

@property (nonatomic, weak) id<FWSliderViewDelegate> delegate;

/** Slider */
@property (nonatomic, strong, readonly) FWSliderButton *sliderBtn;

/** Default slider color */
@property (nonatomic, strong) UIColor *maximumTrackTintColor;

/** Slider progress color */
@property (nonatomic, strong) UIColor *minimumTrackTintColor;

/** Cache progress color */
@property (nonatomic, strong) UIColor *bufferTrackTintColor;

/** loading progress color */
@property (nonatomic, strong) UIColor *loadingTintColor;

/** Picture of the default slider */
@property (nonatomic, strong) UIImage *maximumTrackImage;

/** Picture of slider progress */
@property (nonatomic, strong) UIImage *minimumTrackImage;

/** Picture of cache progress */
@property (nonatomic, strong) UIImage *bufferTrackImage;

/** Slider progress */
@property (nonatomic, assign) float value;

/** Cache progress */
@property (nonatomic, assign) float bufferValue;

/** Whether to allow clicks, the default is YES */
@property (nonatomic, assign) BOOL allowTapped;

/** Whether to allow animation, the default is YES */
@property (nonatomic, assign) BOOL animate;

/** Set the height of the slider */
@property (nonatomic, assign) CGFloat sliderHeight;

/** Set the fillet of the slider */
@property (nonatomic, assign) CGFloat sliderRadius;

/** Whether to hide the slider, default is NO */
@property (nonatomic, assign) BOOL isHideSliderBlock;

/// Whether dragging
@property (nonatomic, assign) BOOL isdragging;

/// Drag forward or backward
@property (nonatomic, assign) BOOL isForward;

@property (nonatomic, assign) CGSize thumbSize;

/**
 *  Starts animation of the spinner.
 */
- (void)startAnimating;

/**
 *  Stops animation of the spinnner.
 */
- (void)stopAnimating;

// Set slider background color
- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state;

// Set slider image
- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state;

@end

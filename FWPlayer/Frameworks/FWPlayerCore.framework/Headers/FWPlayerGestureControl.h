//
//  FWPlayerGestureControl.h
//  FWPlayerCore
//
//  Created by Hui Wang on 2019-06-26.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FWPlayerGestureType) {
    FWPlayerGestureTypeUnknown,
    FWPlayerGestureTypeSingleTap,
    FWPlayerGestureTypeDoubleTap,
    FWPlayerGestureTypePan,
    FWPlayerGestureTypePinch
};

typedef NS_ENUM(NSUInteger, FWPanDirection) {
    FWPanDirectionUnknown,
    FWPanDirectionV,
    FWPanDirectionH,
};

typedef NS_ENUM(NSUInteger, FWPanLocation) {
    FWPanLocationUnknown,
    FWPanLocationLeft,
    FWPanLocationRight,
};

typedef NS_ENUM(NSUInteger, FWPanMovingDirection) {
    FWPanMovingDirectionUnkown,
    FWPanMovingDirectionTop,
    FWPanMovingDirectionLeft,
    FWPanMovingDirectionBottom,
    FWPanMovingDirectionRight,
};

/// This enumeration lists some of the gesture types that the player has by default.
typedef NS_OPTIONS(NSUInteger, FWPlayerDisableGestureTypes) {
    FWPlayerDisableGestureTypesNone         = 0,
    FWPlayerDisableGestureTypesSingleTap    = 1 << 0,
    FWPlayerDisableGestureTypesDoubleTap    = 1 << 1,
    FWPlayerDisableGestureTypesPan          = 1 << 2,
    FWPlayerDisableGestureTypesPinch        = 1 << 3,
    FWPlayerDisableGestureTypesAll          = (FWPlayerDisableGestureTypesSingleTap | FWPlayerDisableGestureTypesDoubleTap | FWPlayerDisableGestureTypesPan | FWPlayerDisableGestureTypesPinch)
};

/// This enumeration lists some of the pan gesture moving direction that the player not support.
typedef NS_OPTIONS(NSUInteger, FWPlayerDisablePanMovingDirection) {
    FWPlayerDisablePanMovingDirectionNone         = 0,       /// Not disable pan moving direction.
    FWPlayerDisablePanMovingDirectionVertical     = 1 << 0,  /// Disable pan moving vertical direction.
    FWPlayerDisablePanMovingDirectionHorizontal   = 1 << 1,  /// Disable pan moving horizontal direction.
    FWPlayerDisablePanMovingDirectionAll          = (FWPlayerDisablePanMovingDirectionVertical | FWPlayerDisablePanMovingDirectionHorizontal)  /// Disable pan moving all direction.
};

@interface FWPlayerGestureControl : NSObject

/// Gesture condition callback.
@property (nonatomic, copy, nullable) BOOL(^triggerCondition)(FWPlayerGestureControl *control, FWPlayerGestureType type, UIGestureRecognizer *gesture, UITouch *touch);

/// Single tap gesture callback.
@property (nonatomic, copy, nullable) void(^singleTapped)(FWPlayerGestureControl *control);

/// Double tap gesture callback.
@property (nonatomic, copy, nullable) void(^doubleTapped)(FWPlayerGestureControl *control);

/// Begin pan gesture callback.
@property (nonatomic, copy, nullable) void(^beganPan)(FWPlayerGestureControl *control, FWPanDirection direction, FWPanLocation location);

/// Pan gesture changing callback.
@property (nonatomic, copy, nullable) void(^changedPan)(FWPlayerGestureControl *control, FWPanDirection direction, FWPanLocation location, CGPoint velocity);

/// End the Pan gesture callback.
@property (nonatomic, copy, nullable) void(^endedPan)(FWPlayerGestureControl *control, FWPanDirection direction, FWPanLocation location);

/// Pinch gesture callback.
@property (nonatomic, copy, nullable) void(^pinched)(FWPlayerGestureControl *control, float scale);

/// The single tap gesture.
@property (nonatomic, strong, readonly) UITapGestureRecognizer *singleTap;

/// The double tap gesture.
@property (nonatomic, strong, readonly) UITapGestureRecognizer *doubleTap;

/// The pan tap gesture.
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *panGR;

/// The pinch tap gesture.
@property (nonatomic, strong, readonly) UIPinchGestureRecognizer *pinchGR;

/// The pan gesture direction.
@property (nonatomic, readonly) FWPanDirection panDirection;

/// The pan location.
@property (nonatomic, readonly) FWPanLocation panLocation;

/// The moving drection.
@property (nonatomic, readonly) FWPanMovingDirection panMovingDirection;

/// The gesture types that the player not support.
@property (nonatomic) FWPlayerDisableGestureTypes disableTypes;

/// The pan gesture moving direction that the player not support.
@property (nonatomic) FWPlayerDisablePanMovingDirection disablePanMovingDirection;

/**
 Add  all gestures(singleTap、doubleTap、panGR、pinchGR) to the view.
 */
- (void)addGestureToView:(UIView *)view;

/**
 Remove all gestures(singleTap、doubleTap、panGR、pinchGR) form the view.
 */
- (void)removeGestureToView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END

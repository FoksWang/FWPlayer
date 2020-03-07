//
//  UIScrollView+FWPlayer.h
//  FWPlayerCore
//
//  Created by Hui Wang on 2019-06-26.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 * The scroll direction of scrollView.
 */
typedef NS_ENUM(NSUInteger, FWPlayerScrollDirection) {
    FWPlayerScrollDirectionNone,
    FWPlayerScrollDirectionUp,         // Scroll up
    FWPlayerScrollDirectionDown,       // Scroll Down
    FWPlayerScrollDirectionLeft,       // Scroll left
    FWPlayerScrollDirectionRight       // Scroll right
};

/*
 * The scrollView direction.
 */
typedef NS_ENUM(NSInteger, FWPlayerScrollViewDirection) {
    FWPlayerScrollViewDirectionVertical,
    FWPlayerScrollViewDirectionHorizontal
};

/*
 * The player container type
 */
typedef NS_ENUM(NSInteger, FWPlayerContainerType) {
    FWPlayerContainerTypeCell,
    FWPlayerContainerTypeView
};

@interface UIScrollView (FWPlayer)

/// When the FWPlayerScrollViewDirection is FWPlayerScrollViewDirectionVertical,the property has value.
@property (nonatomic, readonly) CGFloat fw_lastOffsetY;

/// When the FWPlayerScrollViewDirection is FWPlayerScrollViewDirectionHorizontal,the property has value.
@property (nonatomic, readonly) CGFloat fw_lastOffsetX;

/// The indexPath is playing.
@property (nonatomic, nullable) NSIndexPath *fw_playingIndexPath;

/// The indexPath that should play, the one that lights up.
@property (nonatomic, nullable) NSIndexPath *fw_shouldPlayIndexPath;

/// WWANA networks play automatically,default NO.
@property (nonatomic, getter=fw_isWWANAutoPlay) BOOL fw_WWANAutoPlay;

/// The player should auto player,default is YES.
@property (nonatomic) BOOL fw_shouldAutoPlay;

/// The view tag that the player display in scrollView.
@property (nonatomic) NSInteger fw_containerViewTag;

/// The scrollView scroll direction, default is FWPlayerScrollViewDirectionVertical.
@property (nonatomic) FWPlayerScrollViewDirection fw_scrollViewDirection;

/// The scroll direction of scrollView while scrolling.
/// When the FWPlayerScrollViewDirection is FWPlayerScrollViewDirectionVertical，this value can only be FWPlayerScrollDirectionUp or FWPlayerScrollDirectionDown.
/// When the FWPlayerScrollViewDirection is FWPlayerScrollViewDirectionVertical，this value can only be FWPlayerScrollDirectionLeft or FWPlayerScrollDirectionRight.
@property (nonatomic, readonly) FWPlayerScrollDirection fw_scrollDirection;

/// The video contrainerView type.
@property (nonatomic, assign) FWPlayerContainerType fw_containerType;

/// The video contrainerView in normal model.
@property (nonatomic, strong) UIView *fw_containerView;

/// The currently playing cell stop playing when the cell has out off the screen，defalut is YES.
@property (nonatomic, assign) BOOL fw_stopWhileNotVisible;

/// Has stopped playing
@property (nonatomic, assign) BOOL fw_stopPlay;

/// The block invoked When the player did stop scroll.
@property (nonatomic, copy, nullable) void(^fw_scrollViewDidStopScrollCallback)(NSIndexPath *indexPath);

/// The block invoked When the player did  scroll.
@property (nonatomic, copy, nullable) void(^fw_scrollViewDidScrollCallback)(NSIndexPath *indexPath);

/// The block invoked When the player should play.
@property (nonatomic, copy, nullable) void(^fw_shouldPlayIndexPathCallback)(NSIndexPath *indexPath);

/// Filter the cell that should be played when the scroll is stopped (to play when the scroll is stopped).
- (void)fw_filterShouldPlayCellWhileScrolled:(void (^ __nullable)(NSIndexPath *indexPath))handler;

/// Filter the cell that should be played while scrolling (you can use this to filter the highlighted cell).
- (void)fw_filterShouldPlayCellWhileScrolling:(void (^ __nullable)(NSIndexPath *indexPath))handler;

/// Get the cell according to indexPath.
- (UIView *)fw_getCellForIndexPath:(NSIndexPath *)indexPath;

/// Scroll to indexPath with animations.
- (void)fw_scrollToRowAtIndexPath:(NSIndexPath *)indexPath completionHandler:(void (^ __nullable)(void))completionHandler;

/// add in 3.2.4 version.
/// Scroll to indexPath with animations.
- (void)fw_scrollToRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated completionHandler:(void (^ __nullable)(void))completionHandler;

/// add in 3.2.8 version.
/// Scroll to indexPath with animations duration.
- (void)fw_scrollToRowAtIndexPath:(NSIndexPath *)indexPath animateWithDuration:(NSTimeInterval)duration completionHandler:(void (^ __nullable)(void))completionHandler;

///------------------------------------
/// The following method must be implemented in UIScrollViewDelegate.
///------------------------------------

- (void)fw_scrollViewDidEndDecelerating;

- (void)fw_scrollViewDidEndDraggingWillDecelerate:(BOOL)decelerate;

- (void)fw_scrollViewDidScrollToTop;

- (void)fw_scrollViewDidScroll;

- (void)fw_scrollViewWillBeginDragging;

///------------------------------------
/// end
///------------------------------------


@end

@interface UIScrollView (FWPlayerCannotCalled)

/// The block invoked When the player appearing.
@property (nonatomic, copy, nullable) void(^fw_playerAppearingInScrollView)(NSIndexPath *indexPath, CGFloat playerApperaPercent);

/// The block invoked When the player disappearing.
@property (nonatomic, copy, nullable) void(^fw_playerDisappearingInScrollView)(NSIndexPath *indexPath, CGFloat playerDisapperaPercent);

/// The block invoked When the player will appeared.
@property (nonatomic, copy, nullable) void(^fw_playerWillAppearInScrollView)(NSIndexPath *indexPath);

/// The block invoked When the player did appeared.
@property (nonatomic, copy, nullable) void(^fw_playerDidAppearInScrollView)(NSIndexPath *indexPath);

/// The block invoked When the player will disappear.
@property (nonatomic, copy, nullable) void(^fw_playerWillDisappearInScrollView)(NSIndexPath *indexPath);

/// The block invoked When the player did disappeared.
@property (nonatomic, copy, nullable) void(^fw_playerDidDisappearInScrollView)(NSIndexPath *indexPath);

/// The current player scroll slides off the screen percent.
/// the property used when the `stopWhileNotVisible` is YES, stop the current playing player.
/// the property used when the `stopWhileNotVisible` is NO, the current playing player add to small container view.
/// 0.0~1.0, defalut is 0.5.
/// 0.0 is the player will disappear.
/// 1.0 is the player did disappear.
@property (nonatomic) CGFloat fw_playerDisapperaPercent;

/// The current player scroll to the screen percent to play the video.
/// 0.0~1.0, defalut is 0.0.
/// 0.0 is the player will appear.
/// 1.0 is the player did appear.
@property (nonatomic) CGFloat fw_playerApperaPercent;

/// The current player controller is disappear, not dealloc
@property (nonatomic) BOOL fw_viewControllerDisappear;

@end

NS_ASSUME_NONNULL_END

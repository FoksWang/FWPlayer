//
//  FWPlayerCore.h
//  FWPlayerCore
//
//  Created by Hui Wang on 2019-06-26.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for FWPlayerCore.
FOUNDATION_EXPORT double FWPlayerVersionNumber;

//! Project version string for FWPlayerCore.
FOUNDATION_EXPORT const unsigned char FWPlayerVersionString[];

/**
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

// Output log (Format: [Time] [Which method] [Which line] [Output content])
#ifdef DEBUG
#define NSLog(format, ...)  printf("\n[%s] %s [line %d] 🦊 %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

// Screen width
#define FWPlayerScreenWidth     [[UIScreen mainScreen] bounds].size.width
// Screen height
#define FWPlayerScreenHeight    [[UIScreen mainScreen] bounds].size.height

// AVPlayer
#import "FWAVPlayerManager.h"

// ControlView
#import "FWLandScapeControlView.h"
#import "FWLoadingView.h"
#import "FWNetworkSpeedMonitor.h"
#import "FWPlayerControlView.h"
#import "FWPortraitControlView.h"
#import "FWSliderView.h"
#import "FWSmallFloatControlView.h"
#import "FWSpeedLoadingView.h"
#import "FWUtilities.h"
#import "FWVolumeBrightnessView.h"
#import "UIImageView+FWCache.h"
#import "UIView+FWFrame.h"

// Core
#import "FWFloatView.h"
#import "FWKVOController.h"
#import "FWOrientationObserver.h"
#import "FWPlayerController.h"
#import "FWPlayerGestureControl.h"
#import "FWPlayerLogManager.h"
#import "FWPlayerMediaControl.h"
#import "FWPlayerMediaPlayback.h"
#import "FWPlayerNotification.h"
#import "FWPlayerView.h"
#import "FWReachabilityManager.h"
#import "UIScrollView+FWPlayer.h"
#import "UIViewController+FWPlayerRotation.h"

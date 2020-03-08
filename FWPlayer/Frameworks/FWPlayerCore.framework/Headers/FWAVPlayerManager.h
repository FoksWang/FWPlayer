//
//  FWAVPlayerManager.h
//  FWPlayerCore
//
//  Created by Hui Wang on 2019-06-26.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWPlayerMediaPlayback.h"
#import <AVFoundation/AVFoundation.h>

@interface FWAVPlayerManager : NSObject <FWPlayerMediaPlayback>

@property (nonatomic, strong, readonly) AVURLAsset *asset;
@property (nonatomic, strong, readonly) AVPlayerItem *playerItem;
@property (nonatomic, strong, readonly) AVPlayer *player;
@property (nonatomic, assign) NSTimeInterval timeRefreshInterval;
// request header for videos
@property (nonatomic, strong) NSDictionary *requestHeader;

/**
 Enable media cache, default is NO.
 
 Without changing AVPlayer API, audio and video are cached and downloaded in segments, especially suitable for short videos.
 */
@property (nonatomic, assign) BOOL isEnableMediaCache;

/**
 Allow play sound even the iPhone mute switch off, default is YES.
 */
@property (nonatomic, assign) BOOL isPlaySoundInSilentMode;

+ (NSString *)getVersionNumber;
+ (NSString *)getBuildNumber;

@end

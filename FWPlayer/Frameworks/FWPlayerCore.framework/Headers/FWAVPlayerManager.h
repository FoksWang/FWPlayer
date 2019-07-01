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
// Video request header
@property (nonatomic, strong) NSDictionary *requestHeader;


/**
 Enable media cache, default is off.
 
 Without changing AVPlayer API, audio and video are cached and downloaded in segments, especially suitable for short videos.
 */
@property (nonatomic, assign) BOOL isEnableMediaCache;

- (NSString *)getVersionNumber;
- (NSString *)getBuildNumber;

@end

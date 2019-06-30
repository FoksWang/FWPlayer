//
//  FWPlayerNotification.h
//  FWPlayerCore
//
//  Created by Hui Wang on 2019-06-26.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MPMusicPlayerController.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FWPlayerBackgroundState) {
    FWPlayerBackgroundStateForeground,  // Enter the foreground from the background.
    FWPlayerBackgroundStateBackground,  // From the foreground to the background.
};

@interface FWPlayerNotification : NSObject

@property (nonatomic, readonly) FWPlayerBackgroundState backgroundState;

@property (nonatomic, copy, nullable) void(^willResignActive)(FWPlayerNotification *registrar);

@property (nonatomic, copy, nullable) void(^didBecomeActive)(FWPlayerNotification *registrar);

@property (nonatomic, copy, nullable) void(^newDeviceAvailable)(FWPlayerNotification *registrar);

@property (nonatomic, copy, nullable) void(^oldDeviceUnavailable)(FWPlayerNotification *registrar);

@property (nonatomic, copy, nullable) void(^categoryChange)(FWPlayerNotification *registrar);

@property (nonatomic, copy, nullable) void(^volumeChanged)(float volume);

@property (nonatomic, copy, nullable) void(^audioInterruptionCallback)(AVAudioSessionInterruptionType interruptionType);

- (void)addNotification;

- (void)removeNotification;

@end

NS_ASSUME_NONNULL_END

//
//  FWNetworkSpeedMonitor.h
//  FWPlayerCore
//
//  Created by Hui Wang on 2019-06-27.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const FWDownloadNetworkSpeedNotificationKey;
extern NSString *const FWUploadNetworkSpeedNotificationKey;
extern NSString *const FWNetworkSpeedNotificationKey;

@interface FWNetworkSpeedMonitor : NSObject

@property (nonatomic, copy, readonly) NSString *downloadNetworkSpeed;
@property (nonatomic, copy, readonly) NSString *uploadNetworkSpeed;

- (void)startNetworkSpeedMonitor;
- (void)stopNetworkSpeedMonitor;

@end

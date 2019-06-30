//
//  FWUtilities.h
//  FWPlayerCore
//
//  Created by Hui Wang on 2019-06-27.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// iPhoneX  iPhoneXS  iPhoneXS Max  iPhoneXR 机型判断
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ((NSInteger)(([[UIScreen mainScreen] currentMode].size.height/[[UIScreen mainScreen] currentMode].size.width)*100) == 216) : NO)

#define FWPlayer_Image(file)                 [FWUtilities imageNamed:file]

// 屏幕的宽
#define FWPlayer_ScreenWidth                 [[UIScreen mainScreen] bounds].size.width
// 屏幕的高
#define FWPlayer_ScreenHeight                [[UIScreen mainScreen] bounds].size.height

@interface FWUtilities : NSObject

+ (NSString *)convertTimeSecond:(NSInteger)timeSecond;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageNamed:(NSString *)name;

@end


//
//  ShareSDKPlugin.h
//  ShareSDKPlugin
//
//  Created by 刘靖煌 on 16/8/30.
//  Copyright © 2016年 mob.com. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface ShareSDKPlugin : NSObject

+ (instancetype)sharedPlugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end
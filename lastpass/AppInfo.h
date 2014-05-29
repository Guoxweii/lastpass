//
//  AppInfo.h
//  lastpass
//
//  Created by gxw on 14-5-28.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfo : NSObject
+ (AppInfo *)instance;

- (NSString *)current_password_info;
- (void)store_password_info:(NSString *)info;

- (NSString *)current_valid;
- (void)store_valid:(NSString *)valid;

- (NSString *)current_pin;
- (void)store_pin:(NSString *)pin;
@end

//
//  AppInfo.m
//  lastpass
//
//  Created by gxw on 14-5-28.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import "AppInfo.h"

static AppInfo* AppInfoInstance = nil;

@implementation AppInfo

+ (AppInfo *)instance {
	if (!AppInfoInstance) {
        AppInfoInstance = [[AppInfo alloc] init];
    }
    
    return AppInfoInstance;
}

- (NSString *)current_password_info {
	return [[NSUserDefaults standardUserDefaults] stringForKey:@"password_info"];
}

- (void)store_password_info:(NSString *)info {
	[[NSUserDefaults standardUserDefaults] setValue:info forKey:@"password_info"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end

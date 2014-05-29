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

- (NSString *)current_pin {
	return [[NSUserDefaults standardUserDefaults] stringForKey:@"pin"];
}

- (void)store_pin:(NSString *)pin {
	[[NSUserDefaults standardUserDefaults] setValue:pin forKey:@"pin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)current_valid {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"valid"];
}

- (void)store_valid:(NSString *)valid {
	[[NSUserDefaults standardUserDefaults] setValue:valid forKey:@"valid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end

//
//  Grubby.m
//  lastpass
//
//  Created by gxw on 14-5-28.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import "Grubby.h"
#import "AppInfo.h"

static Grubby* grubbyInstance = nil;

@implementation Grubby

+ (Grubby *)instance {
	if (!grubbyInstance) {
        grubbyInstance = [[Grubby alloc] init];
    }
    
    return grubbyInstance;
}

- (void)fetch_remote_html:(NSString *)url {
	NSURL *webUrl = [NSURL URLWithString:url];
    NSError *err;
    
    if (![webUrl checkResourceIsReachableAndReturnError:&err]) {
        [self showErrorWithInvalidUrl];
    }
}

- (void)showErrorWithInvalidUrl {
	[_mainCtr showErrorWithInvalidUrl];
}
@end

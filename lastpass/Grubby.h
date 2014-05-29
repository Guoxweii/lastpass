//
//  Grubby.h
//  lastpass
//
//  Created by gxw on 14-5-28.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"

@interface Grubby : NSObject
@property (nonatomic,retain) MainViewController *mainCtr;
@property (nonatomic,retain) NSMutableDictionary *dataSource;

+ (Grubby *)instance;
- (void)fetch_remote_html:(NSString *)url;
- (void)parse:(NSString *)passInfo;
- (void)resetDataSource;
@end

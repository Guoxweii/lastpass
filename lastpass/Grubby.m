//
//  Grubby.m
//  lastpass
//
//  Created by gxw on 14-5-28.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import "Grubby.h"
#import "AppInfo.h"
#import "TFHpple.h"

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
    NSData *data = [NSData dataWithContentsOfURL:webUrl];
    if (!data) {
        [self showErrorWithInvalidUrl];
        return;
    }

    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *elements  = [doc searchWithXPathQuery:@"//pre"];
    if ([elements count] == 0) {
        [self showErrorWithInvalidUrl];
        return ;
    }
    
    NSString *passInfo = [[elements objectAtIndex:0] text];
	[self parse:passInfo];
    
    if ([[_dataSource allKeys] count] > 0) {
        [_mainCtr fetchResultSuccess];
    }
}

- (void)showErrorWithInvalidUrl {
	[_mainCtr showErrorWithInvalidUrl];
}

- (void)parse:(NSString *)passInfo {
    [[AppInfo instance] store_password_info:passInfo];
    
	NSMutableArray *data = [[passInfo componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]] mutableCopy];
    if ([data count] < 2) { return; };
    
    _dataSource = [[NSMutableDictionary alloc] init];
    for (int i=1; i<[data count]; i++) {
        NSString *dataline = [data objectAtIndex:i];
 		NSMutableArray *datalineArray = [[dataline componentsSeparatedByString:@","] mutableCopy];
        
        if ([datalineArray count] < 7) { continue; }
        
        if ([datalineArray objectAtIndex:5] && ![[datalineArray objectAtIndex:5] isEqualToString:@""]) {
            if (![_dataSource objectForKey:[datalineArray objectAtIndex:5]]) {
                NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
                [_dataSource setObject:categoryArray forKey:[datalineArray objectAtIndex:5]];
            }
            
            NSMutableArray *categoryArrayNow = [_dataSource objectForKey:[datalineArray objectAtIndex:5]];
            [categoryArrayNow addObject:@[[datalineArray objectAtIndex:0],
                                            [datalineArray objectAtIndex:1],
                                            [datalineArray objectAtIndex:2],
                                            [datalineArray objectAtIndex:4],
                                            [datalineArray objectAtIndex:5],
                                            [datalineArray objectAtIndex:6]
                                            ]];
            
        } else {
        	if (![_dataSource objectForKey:@"无分组"]) {
            	NSMutableArray *noArray = [[NSMutableArray alloc] init];
				[_dataSource setObject:noArray forKey:@"无分组"];
            }
            NSMutableArray *noCategoryArrayNow = [_dataSource objectForKey:@"无分组"];
            [noCategoryArrayNow addObject:@[[datalineArray objectAtIndex:0],
                                         [datalineArray objectAtIndex:1],
                                         [datalineArray objectAtIndex:2],
                                         [datalineArray objectAtIndex:4],
                                         [datalineArray objectAtIndex:5],
                                         [datalineArray objectAtIndex:6]
                                        ]];
        }
    }
}

- (void)resetDataSource {
	[self setDataSource:nil];
    [[AppInfo instance] store_password_info:nil];
}
@end

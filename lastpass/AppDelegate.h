//
//  AppDelegate.h
//  lastpass
//
//  Created by gxw on 14-5-28.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pinController.h"
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) pinController *pinCtr;
@end

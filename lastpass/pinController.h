//
//  pinController.h
//  lastpass
//
//  Created by gxw on 14-5-29.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APPinViewController.h"

@interface pinController : UIViewController<APPinViewControllerDelegate>
@property (retain, nonatomic) UINavigationController *baseNaviCtr;

- (void)createPin;
- (void)verityPin;
@end

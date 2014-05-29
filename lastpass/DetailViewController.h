//
//  DetailViewController.h
//  lastpass
//
//  Created by gxw on 14-5-29.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *login;
@property (strong, nonatomic) IBOutlet UILabel *password;
@property (strong, nonatomic) NSString *loginValue;
@property (strong, nonatomic) NSString *passwordValue;
@end

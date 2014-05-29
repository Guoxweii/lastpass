//
//  DetailViewController.h
//  lastpass
//
//  Created by gxw on 14-5-29.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *login;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) NSString *loginValue;
@property (strong, nonatomic) NSString *passwordValue;
@property (strong, nonatomic) IBOutlet UIButton *passwordCopyButton;
@property (strong, nonatomic) IBOutlet UIButton *loginCopyButton;

- (IBAction)loginCopy:(UIButton *)sender;
- (IBAction)passwordCopy:(UIButton *)sender;
@end

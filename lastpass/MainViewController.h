//
//  MainViewController.h
//  lastpass
//
//  Created by gxw on 14-5-28.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *urlField;

- (void)showErrorWithInvalidUrl;
- (void)fetchResultSuccess;
- (IBAction)loadWebView:(UIButton *)sender;
@end

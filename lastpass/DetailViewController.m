//
//  DetailViewController.m
//  lastpass
//
//  Created by gxw on 14-5-29.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import "DetailViewController.h"
#import "MBProgressHUD.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _password.enabled = NO;
    _password.enabled = NO;
    
    _passwordCopyButton.layer.cornerRadius = 3.0f;
    _passwordCopyButton.layer.borderWidth = 1.0f;
    _passwordCopyButton.layer.borderColor = [UIColor blueColor].CGColor;
    
    _loginCopyButton.layer.cornerRadius = 3.0f;
    _loginCopyButton.layer.borderWidth = 1.0f;
    _loginCopyButton.layer.borderColor = [UIColor blueColor].CGColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
    [self.login setText:_loginValue];
    [self.password setText:_passwordValue];
}


- (IBAction)loginCopy:(UIButton *)sender {
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = _loginValue;
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"登录名拷贝成功.";
    HUD.mode = MBProgressHUDModeText;
    HUD.dimBackground = YES;
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(1.5f);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}

- (IBAction)passwordCopy:(UIButton *)sender {
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = _passwordValue;
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"密码拷贝成功.";
    HUD.mode = MBProgressHUDModeText;
    HUD.dimBackground = YES;
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(1.5f);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}
@end

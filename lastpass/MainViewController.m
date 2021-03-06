//
//  MainViewController.m
//  lastpass
//
//  Created by gxw on 14-5-28.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import "MainViewController.h"
#import "ListViewController.h"
#import "MBProgressHUD.h"
#import "Grubby.h"
#import "AppDelegate.h"
#import "AppInfo.h"
#import "BaseWebViewController.h"

@interface MainViewController ()<UITextFieldDelegate> {
	BOOL loading;
	MBProgressHUD *HUD;
}

@end

@implementation MainViewController

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
    self.title = @"数据导入";
    
    if ([[AppInfo instance] current_password_info]) {
        [self redirectToList];
    } else {
        [self.urlField becomeFirstResponder];
        loading = NO;
        HUD = nil;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (loading) { return YES; }
    loading = YES;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.dimBackground = YES;
        HUD.labelText = @"loading..";
        HUD.yOffset = -120.0f;
        [HUD show:YES];
    });
    
    [[Grubby instance] setMainCtr:self];
    [[Grubby instance] performSelector:@selector(fetch_remote_html:) withObject:_urlField.text afterDelay:1.0f];
    
    return YES;
}

- (void)showErrorWithInvalidUrl {
    
    dispatch_async(dispatch_get_main_queue(), ^{
		if (HUD) {
            [HUD removeFromSuperview];
            HUD = nil;
        }
        
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.labelText = @"url地址错误.";
        HUD.mode = MBProgressHUDModeText;
        HUD.dimBackground = YES;
        HUD.yOffset = -120.0f;
        
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(2);
        } completionBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (HUD) {
                    [HUD removeFromSuperview];
                    HUD = nil;
                }
                
                loading = NO;
            });
            
        }];
    });
}

- (void)fetchResultSuccess {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (HUD) {
            [HUD removeFromSuperview];
            HUD = nil;
        }
        loading = NO;
    });
    
	[self redirectToList];
}

- (IBAction)loadWebView:(UIButton *)sender {
    BaseWebViewController *webView = [[BaseWebViewController alloc] initWithNibName:@"BaseWebViewController" bundle:nil];
    [self.navigationController pushViewController:webView animated:YES];
}

- (void)redirectToList {
	[[Grubby instance] parse:[[AppInfo instance] current_password_info]];
    ListViewController *listCtr = [[ListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
    [self.navigationController setViewControllers:@[listCtr]];
}
@end

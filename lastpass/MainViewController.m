//
//  MainViewController.m
//  lastpass
//
//  Created by gxw on 14-5-28.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import "MainViewController.h"
#import "MBProgressHUD.h"
#import "Grubby.h"
#import "AppDelegate.h"

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
    
    [self.urlField becomeFirstResponder];
    loading = NO;
    HUD = nil;
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
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.dimBackground = YES;
    HUD.labelText = @"loading..";
    [HUD show:YES];
    
    [[Grubby instance] setMainCtr:self];
    [[Grubby instance] fetch_remote_html:_urlField.text];
    
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
    
	AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate redirect_to_list];
}
@end

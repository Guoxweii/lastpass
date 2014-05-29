//
//  pinController.m
//  lastpass
//
//  Created by gxw on 14-5-29.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import "pinController.h"
#import "AppInfo.h"
#import "AppDelegate.h"

@interface pinController ()

@end

@implementation pinController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createPin {
    APPinViewController *pinCtr = [[APPinViewController alloc] initWithNibName:@"APPinViewController" bundle:nil];
    pinCtr.delegate = self;
    [pinCtr setIsCreated:NO];
	_baseNaviCtr = [[UINavigationController alloc] initWithRootViewController:pinCtr];
    
    [self presentViewController:_baseNaviCtr animated:YES completion:nil];
}

- (void)verityPin {
	APPinViewController *pinCtr = [[APPinViewController alloc] initWithNibName:@"APPinViewController" bundle:nil];
    pinCtr.delegate = self;
    [pinCtr setIsCreated:YES];
    pinCtr.pinCodeToCheck = [[AppInfo instance] current_pin];
	_baseNaviCtr = [[UINavigationController alloc] initWithRootViewController:pinCtr];
    
    [self presentViewController:_baseNaviCtr animated:YES completion:nil];
}

#pragma mark - Delegates
//Create
- (void)pinCodeViewController:(APPinViewController *)controller didCreatePinCode:(NSString *)pinCode {
	[[AppInfo instance] store_pin:pinCode];
    [[AppInfo instance] store_valid:@"valid"];
	[_baseNaviCtr dismissViewControllerAnimated:YES completion:^{
        [self hidePinView];
    }];
}

//Verify
- (void)pinCodeViewController:(APPinViewController *)controller didVerifiedPincodeSuccessfully:(NSString *)pinCode {
    [[AppInfo instance] store_valid:@"valid"];
	[_baseNaviCtr dismissViewControllerAnimated:YES completion:^{
        [self hidePinView];
    }];
}

//Change
- (void)pinCodeViewController:(APPinViewController *)controller didChangePinCode:(NSString *)pinCode {
	[[AppInfo instance] store_pin:pinCode];
    [[AppInfo instance] store_valid:@"valid"];
	[_baseNaviCtr dismissViewControllerAnimated:YES completion:^{
        [self hidePinView];
    }];
}

- (void)hidePinView {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
    if ([[[AppInfo instance] current_valid] isEqualToString:@"valid"]) { return; }
    
    if([[AppInfo instance] current_pin]) {
        [self verityPin];
    } else {
        [self createPin];
    }
}
@end

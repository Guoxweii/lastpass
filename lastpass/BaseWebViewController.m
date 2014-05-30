//
//  BaseWebViewController.m
//  lastpass
//
//  Created by gxw on 14-5-30.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController () {
}

@end

@implementation BaseWebViewController

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
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://lastpass.com/index.php?ac=1"]];
    [self.webView loadRequest:request];
    
    [_popView setFrame:CGRectMake(0, DEVICE_FULL_HEIGHT, DEVICE_FULL_WIDTH, DEVICE_FULL_HEIGHT)];
    [self.view addSubview:_popView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	
    if ([[self.webView stringByEvaluatingJavaScriptFromString:@"$('#buttonsigningo').length"] isEqualToString:@"1"]) {
        [self showLoginFrame];
    } else if ([[self.webView stringByEvaluatingJavaScriptFromString:@"$('#export').length"] isEqualToString:@"1"]) {
        [self.webView stringByEvaluatingJavaScriptFromString:@"$('#person').click()"];
    	[self.webView stringByEvaluatingJavaScriptFromString:@"$('#export a').click()"];
    } else if ([[self.webView stringByEvaluatingJavaScriptFromString:@"$('#output').length"] isEqualToString:@"1"] && [[self.webView stringByEvaluatingJavaScriptFromString:@"$('#output pre').length"] isEqualToString:@"0"]) {
        [self performSelector:@selector(fetchData) withObject:nil afterDelay:5.0];
    }
}

- (void)fetchData {
    if([[self.webView stringByEvaluatingJavaScriptFromString:@"$('#output pre').length"] isEqualToString:@"1"]) {
    	NSLog(@"111");
    } else {
        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$('#pw').val('%@').submit();", _password.text]];
    	[self performSelector:@selector(fetchData) withObject:nil afterDelay:2.0];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	
}

- (void)showLoginFrame {
    [UIView animateWithDuration:0.3
                     animations:^{
                         [_popView setFrame:CGRectMake(0, 0, DEVICE_FULL_WIDTH, DEVICE_FULL_HEIGHT)];
                     }
                     completion:^(BOOL finished){
                     }];
}

- (IBAction)submit:(UIButton *)sender {
    [UIView animateWithDuration:0.3
                     animations:^{
                         [_popView setFrame:CGRectMake(0, DEVICE_FULL_HEIGHT, DEVICE_FULL_WIDTH, DEVICE_FULL_HEIGHT)];
                     }
                     completion:^(BOOL finished){
                         [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$('#email').val('%@')", _login.text]];
                         [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$('#password').val('%@')", _password.text]];
                         [self.webView stringByEvaluatingJavaScriptFromString:@"$('.nowrap').click()"];
                     }];
}
@end

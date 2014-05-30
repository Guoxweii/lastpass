//
//  ListViewController.h
//  lastpass
//
//  Created by gxw on 14-5-29.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIButton *resetButton;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

- (IBAction)reset:(id)sender;
- (IBAction)search:(UIButton *)sender;
- (void)cacenSearch;
- (void)pushWithkey:(NSString *)key andIndex:(NSInteger)index;
@end
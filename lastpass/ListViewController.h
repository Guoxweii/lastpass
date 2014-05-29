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

- (IBAction)reset:(id)sender;
@end
//
//  SearchViewController.h
//  lastpass
//
//  Created by gxw on 14-5-30.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"
@interface SearchViewController : UIViewController<UISearchBarDelegate,UISearchDisplayDelegate>
@property (retain,nonatomic) ListViewController *listCtr;
@end
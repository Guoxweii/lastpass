//
//  SearchViewController.m
//  lastpass
//
//  Created by gxw on 14-5-30.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import "SearchViewController.h"
#import "Grubby.h"

@interface SearchViewController (){
	NSMutableArray *dataArray;
}

@end

@implementation SearchViewController

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
    dataArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	[dataArray removeAllObjects];
    
    NSMutableDictionary *lastpassData = [[Grubby instance] dataSource];
    for (int i=0; i<[[lastpassData allKeys] count]; i++) {
        NSString *key = [[lastpassData allKeys] objectAtIndex:i];
        NSMutableArray *groupData = [lastpassData objectForKey:key];
        
        for (int j=0; j<[groupData count]; j++) {
            NSArray *info = [groupData objectAtIndex:j];
            
            if ([self judgeString:[info objectAtIndex:0] containSubstring:searchText] || [self judgeString:[info objectAtIndex:3] containSubstring:searchText]) {
                [dataArray addObject:@[key, [NSString stringWithFormat:@"%i",j], [info objectAtIndex:3]]];
            }
        }
    }
}

- (BOOL)judgeString:(NSString *)mainString containSubstring:(NSString *)substring {
    NSString *mainUpString = [mainString uppercaseStringWithLocale:NSLocaleCurrencyCode];
    NSString *subUpString = [substring uppercaseStringWithLocale:NSLocaleCurrencyCode];
    return [mainUpString rangeOfString:subUpString].location == NSNotFound ? FALSE : YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
	[_listCtr cacenSearch];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchCell"];
    cell.textLabel.text = [[dataArray objectAtIndex:indexPath.row] objectAtIndex:2];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[_listCtr cacenSearch];
    [_listCtr pushWithkey:[[dataArray objectAtIndex:indexPath.row] objectAtIndex:0] andIndex:[[[dataArray objectAtIndex:indexPath.row] objectAtIndex:1] intValue]];
}

@end

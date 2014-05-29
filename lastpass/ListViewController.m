//
//  ListViewController.m
//  lastpass
//
//  Created by gxw on 14-5-29.
//  Copyright (c) 2014年 bstar. All rights reserved.
//

#import "ListViewController.h"
#import "Grubby.h"
#import "baseCell.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "AppInfo.h"

@interface ListViewController ()<UIActionSheetDelegate>

@end

@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"密码列表";
    static NSString *baseName = @"baseCell";
    [self.tableView registerNib:[UINib nibWithNibName:@"baseCell" bundle:nil] forCellReuseIdentifier:baseName];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_resetButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_searchButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[[[Grubby instance] dataSource] allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *key = [[[[Grubby instance] dataSource] allKeys] objectAtIndex:section];
    NSMutableArray *array = [[[Grubby instance] dataSource] objectForKey:key];
    return [array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *baseName = @"baseCell";
    baseCell *cell = [tableView dequeueReusableCellWithIdentifier:baseName forIndexPath:indexPath];
    
    NSString *key = [[[[Grubby instance] dataSource] allKeys] objectAtIndex:indexPath.section];
	[cell.name setText:[[[[[Grubby instance] dataSource] objectForKey:key] objectAtIndex:indexPath.row] objectAtIndex:3]];
    
    NSString *url = [[[[[Grubby instance] dataSource] objectForKey:key] objectAtIndex:indexPath.row] objectAtIndex:0];
    NSURL *passwordUrl = [NSURL URLWithString:url];

    NSString *logoUrl;
    if ([passwordUrl port]) {
		logoUrl = [NSString stringWithFormat:@"%@://%@:%@/favicon.ico",[passwordUrl scheme],[passwordUrl host],[passwordUrl port]];
    } else {
    	logoUrl = [NSString stringWithFormat:@"%@://%@/favicon.ico",[passwordUrl scheme],[passwordUrl host]];
    }
    
    [cell.logo setImageWithURL:[NSURL URLWithString:logoUrl]
                placeholderImage:[UIImage imageNamed:@"bg"]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[[[Grubby instance] dataSource] allKeys] objectAtIndex:section];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailView = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    NSString *key = [[[[Grubby instance] dataSource] allKeys] objectAtIndex:indexPath.section];
    [detailView setTitle:[[[[[Grubby instance] dataSource] objectForKey:key] objectAtIndex:indexPath.row] objectAtIndex:3]];
    [detailView setLoginValue:[[[[[Grubby instance] dataSource] objectForKey:key] objectAtIndex:indexPath.row] objectAtIndex:1]];
    [detailView setPasswordValue:[[[[[Grubby instance] dataSource] objectForKey:key] objectAtIndex:indexPath.row] objectAtIndex:2]];

    [self.navigationController pushViewController:detailView animated:YES];
}

- (IBAction)reset:(id)sender {
    UIActionSheet *resetSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:@"重置"
                                                   otherButtonTitles:nil,nil];
    resetSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [resetSheet showInView:self.view];
}

- (IBAction)search:(UIButton *)sender {
    NSLog(@"search");
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
        [self resetList];
    }
}

- (void)resetList {
    [[AppInfo instance] store_password_info:nil];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate autoRedirect];
}
@end

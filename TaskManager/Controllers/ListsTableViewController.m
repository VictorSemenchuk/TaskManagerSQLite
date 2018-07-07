//
//  ListsTableViewController.m
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ListsTableViewController.h"
#import "NewListTableViewController.h"
#import "ListTableViewCell.h"

static NSString * const kCellIdentifier = @"CellIdentifier";

@interface ListsTableViewController ()

@property (nonatomic) NSMutableArray *lists;

- (void)setupViews;

@end

@implementation ListsTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Lists";
    self.lists = [NSMutableArray array];
    [self.tableView registerClass:ListTableViewCell.class forCellReuseIdentifier:kCellIdentifier];
    
    [self setupViews];
}

#pragma mark - Methods

- (void)setupViews {
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add list" style:UIBarButtonItemStylePlain target:self action:@selector(addList)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

#pragma mark - Target actions

- (void)addList {
    NewListTableViewController *vc = [[NewListTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [self.lists count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    List *list = [[List alloc] initWithTitle:@"MyList" iconTitle:@"icon8" andColor:UIColor.redColor];
    [cell installAttributesForList:list];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.lists removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

@end

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
#import "DatabaseManager.h"
#import "ListTableViewController.h"
#import "Icon.h"

static NSString * const kCellIdentifier = @"CellIdentifier";

@interface ListsTableViewController () <NewListTableViewControllerDelegate>

@property (nonatomic) NSMutableArray *lists;

- (void)setupViews;
- (void)loadData;

@end

@implementation ListsTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    self.title = @"Lists";
    [self.tableView registerClass:ListTableViewCell.class forCellReuseIdentifier:kCellIdentifier];
    
    [self setupViews];
}

#pragma mark - Methods

- (void)setupViews {
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add list" style:UIBarButtonItemStylePlain target:self action:@selector(addList)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

- (void)loadData {
    if (self.lists != nil) {
        [self.lists removeAllObjects];
        self.lists = nil;
    }
    self.lists = [List loadAllLists];
    for(List *list in self.lists) {
        NSLog(@"colorId: %lu, iconId: %lu", list.colorId, list.iconId);
    }
    [self.tableView reloadData];
}

#pragma mark - Target actions

- (void)addList {
    NewListTableViewController *vc = [[NewListTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    [cell installAttributesForList:self.lists[indexPath.row]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        List *list = self.lists[indexPath.row];
        [List removeListWithId:list.listId];
        [self.lists removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewController *listTable = [[ListTableViewController alloc] initWithList:self.lists[indexPath.row]];
    [self.navigationController pushViewController:listTable animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

#pragma mark - NewListTableViewControllerDelegate

- (void)newListAdded {
    [self loadData];
}

@end

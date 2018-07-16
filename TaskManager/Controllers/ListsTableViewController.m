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
#import "ListTableViewController.h"
#import "IconSQLiteService.h"
#import "ListSQLiteService.h"

static NSString * const kCellIdentifier = @"CellIdentifier";

@interface ListsTableViewController () <NewListTableViewControllerDelegate, ListTableViewControllerDelegate>

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
    ListSQLiteService *listSQLiteService = [[ListSQLiteService alloc] init];
    self.lists = [listSQLiteService loadAllLists];
    for(List *list in self.lists) {
        NSUInteger uncompletedTasksCount = [listSQLiteService getCountUncheckedTasksForListId:list.listId];
        list.uncheckedTasksCount = uncompletedTasksCount;
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
        ListSQLiteService *listSQLiteService = [[ListSQLiteService alloc] init];
        List *list = self.lists[indexPath.row];
        [listSQLiteService removeListWithId:list.listId];
        [self.lists removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewController *listTable = [[ListTableViewController alloc] initWithList:self.lists[indexPath.row]];
    listTable.delegate = self;
    [self.navigationController pushViewController:listTable animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

#pragma mark - NewListTableViewControllerDelegate

- (void)newListAddedWithTitle:(NSString *)title colorId:(NSUInteger)colorId iconId:(NSUInteger)iconId {
    ListSQLiteService *listSQLiteService = [[ListSQLiteService alloc] init];
    NSUInteger newListId = [DatabaseManager getLastIdForList:@"lists"];
    List *newList = [listSQLiteService loadListWithId:newListId];
    [self.lists addObject:newList];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.lists count] - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

#pragma mark - ListTableViewControllerDelegate

- (void)wasEditedList:(List *)list {
    ListSQLiteService *listSQLiteService = [[ListSQLiteService alloc] init];
    NSUInteger listIndex = [self.lists indexOfObject:list];
    List *editedList = self.lists[listIndex];
    NSUInteger countUncompletedTasks = [listSQLiteService getCountUncheckedTasksForListId:editedList.listId];
    editedList.uncheckedTasksCount = countUncompletedTasks;
    [self.lists replaceObjectAtIndex:listIndex withObject:editedList];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:listIndex inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end

//
//  ListTableViewController.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ListTableViewController.h"
#import "ListItemTableViewCell.h"
#import "DatabaseManager.h"
#import "AddTaskTableViewController.h"
#import "EditTaskTableViewController.h"

static NSString * const kListItemCellIdentifier = @"kListItemCellIdentifier";

@interface ListTableViewController () <AddTaskTableViewControllerDelegate, EditTaskTableViewControllerDelegate>
@property (assign, nonatomic) BOOL listWasEdited;

- (void)setupViews;
- (void)newTask;
- (void)loadData;

@end

@implementation ListTableViewController

- (id)initWithList:(List *)list {
    self = [super init];
    if (self) {
        _list = list;
        _listWasEdited = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.list.title;
    [self.tableView registerClass:[ListItemTableViewCell class] forCellReuseIdentifier:kListItemCellIdentifier];
    
    [self loadData];
    [self setupViews];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.listWasEdited) {
        [self.delegate wasEditedList:self.list];
    }
}

#pragma mark - Methods

- (void)setupViews {
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New task" style:UIBarButtonItemStylePlain target:self action:@selector(newTask)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

- (void)loadData {
    if (self.tasks != nil) {
        [self.tasks removeAllObjects];
        self.tasks = nil;
    }
    self.tasks = [[NSMutableArray alloc] initWithArray:[Task loadTasksForListWithId:self.list.listId]];
    [self.tableView reloadData];
}

#pragma mark - Target actions

- (void)newTask {
    AddTaskTableViewController *vc = [[AddTaskTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.list = self.list;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - AddTaskTableViewControllerDelegate

- (void)addedTask:(Task *)task {
    [self.tasks addObject:task];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.tasks count] - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    self.listWasEdited = YES;
}

#pragma mark - AddTaskTableViewControllerDelegate

- (void)changedTask:(Task *)task atIndexPath:(NSIndexPath *)indexPath {
    [self.tasks replaceObjectAtIndex:indexPath.row withObject:task];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tasks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kListItemCellIdentifier forIndexPath:indexPath];
    [cell setAttributesForTask:self.tasks[indexPath.row] andList:self.list];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Task *task = self.tasks[indexPath.row];
    [Task updateCheckForTaskWithId:task.taskId oldValue:task.isChecked];
    task.isChecked = !task.isChecked;
    [self.tasks replaceObjectAtIndex:indexPath.row withObject:task];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    self.listWasEdited = YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        Task *task = self.tasks[indexPath.row];
        EditTaskTableViewController *vc = [[EditTaskTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        vc.task = task;
        vc.indexPath = indexPath;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        Task *task = self.tasks[indexPath.row];
        [Task removeTaskWithId:task.taskId];
        [self.tasks removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        self.listWasEdited = YES;
    }];
    deleteAction.backgroundColor = UIColor.redColor;
    return @[deleteAction, editAction];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

@end

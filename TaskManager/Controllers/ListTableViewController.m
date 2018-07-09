//
//  ListTableViewController.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ListTableViewController.h"
#import "ListItemTableViewCell.h"

static NSString * const kListItemCellIdentifier = @"kListItemCellIdentifier";

@interface ListTableViewController ()

- (void)setupViews;
- (void)newTask;
- (void)loadData;

@end

@implementation ListTableViewController

- (id)initWithList:(List *)list {
    self = [super init];
    if (self) {
        _list = list;
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
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"New task" message:@"Enter text of your new task" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Text";
        textField.keyboardType = UIKeyboardTypeDefault;
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *text = alertController.textFields.firstObject.text;
        if ([text isEqualToString:@""] || text == nil) {
            return;
        } else {
            [Task addNewTaskWithText:text andListId:self.list.listId];
            [self loadData];
        }
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:doneAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
    [self loadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Task *task = self.tasks[indexPath.row];
        [Task removeTaskWithId:task.taskId];
        [self.tasks removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end

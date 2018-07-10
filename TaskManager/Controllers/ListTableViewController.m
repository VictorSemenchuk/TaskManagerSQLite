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

static NSString * const kListItemCellIdentifier = @"kListItemCellIdentifier";

@interface ListTableViewController ()

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
            
            NSUInteger newTaskId = [DatabaseManager getLastIdForList:@"tasks"];
            Task *newTask = [[Task alloc] initWithId:newTaskId listId:self.list.listId text:text isChecked:NO];
            [self.tasks addObject:newTask];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.tasks count] - 1 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
            self.listWasEdited = YES;
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
    task.isChecked = !task.isChecked;
    [self.tasks replaceObjectAtIndex:indexPath.row withObject:task];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    self.listWasEdited = YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

        Task *task = self.tasks[indexPath.row];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Edit task" message:@"Change text of your task" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = task.text;
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
                [Task updateTaskWithId:task.taskId text:text];
                Task *task = self.tasks[indexPath.row];
                task.text = text;
                [self.tasks replaceObjectAtIndex:indexPath.row withObject:task];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alertController addAction:doneAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
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

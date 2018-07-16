//
//  AddTaskTableViewController.m
//  TaskManager
//
//  Created by Victor Macintosh on 10/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "AddTaskTableViewController.h"
#import "DatabaseManager.h"
#import "TaskSQLiteService.h"

@implementation AddTaskTableViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.priority = 0;
}

#pragma mark - Target methods

- (void)done {
    if ([self.text isEqualToString:@""] || self.text == nil) {
        return;
    } else {
        TaskSQLiteService *taskSQLiteService = [[TaskSQLiteService alloc] init];
        [taskSQLiteService addNewTaskWithText:self.text priority:self.priority andListId:self.list.listId];
        NSUInteger newTaskId = [DatabaseManager getLastIdForList:@"tasks"];
        Task *newTask = [[Task alloc] initWithId:newTaskId listId:self.list.listId text:self.text isChecked:NO priority:self.priority];
        [self.delegate addedTask:newTask];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end

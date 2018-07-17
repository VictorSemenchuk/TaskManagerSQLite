//
//  AddTaskTableViewController.m
//  TaskManager
//
//  Created by Victor Macintosh on 10/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "AddTaskTableViewController.h"
#import "DatabaseManager.h"
#import "UIViewController+AlertCategory.h"

@implementation AddTaskTableViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.priority = 0;
}

#pragma mark - Target methods

- (void)done {
    if ([self.text isEqualToString:@""] || self.text == nil) {
        [self showErrorAlertWithTitle:@"Oops" andMessage:@"Enter text for your task"];
    } else {
        DatabaseManager *databaseManager = [[DatabaseManager alloc] init];
        NSUInteger newTaskId = [databaseManager getLastIdForEntity:@"tasks"] + 1;
        
        TaskService *taskService = [[TaskService alloc] init];
        [taskService addNewTaskWithText:self.text priority:self.priority andListId:self.list.listId];
        //NSUInteger newTaskId = [DatabaseManager getLastIdForList:@"tasks"];
        Task *newTask = [[Task alloc] initWithId:newTaskId listId:self.list.listId text:self.text isChecked:NO priority:self.priority];
        [self.delegate addedTask:newTask];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end

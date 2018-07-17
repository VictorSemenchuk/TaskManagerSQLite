//
//  EditTaskTableViewController.m
//  TaskManager
//
//  Created by Victor Macintosh on 10/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "EditTaskTableViewController.h"
#import "UIViewController+AlertCategory.h"

@interface EditTaskTableViewController ()

@end

@implementation EditTaskTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.priority = self.task.priority;
    self.text = self.task.text;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        EditableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTextCellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        [cell installText:self.task.text];
        return cell;
    } else {
        SegmentControlTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPriorityCellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        [cell setTitle:@"Priority" items:self.priorities selectedIndex:self.priority];
        return cell;
    }
}

- (void)done {
    if ([self.text isEqualToString:@""] || self.text == nil) {
        [self showErrorAlertWithTitle:@"Oops" andMessage:@"Enter text for your task"];
    } else {
        TaskService *taskService = [[TaskService alloc] init];
        [taskService updateTaskWithId:self.task.taskId text:self.text priority:self.priority];
        self.task.text = self.text;
        self.task.priority = self.priority;
        [self.delegate changedTask:self.task atIndexPath:self.indexPath];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end

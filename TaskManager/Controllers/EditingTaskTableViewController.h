//
//  EditingTaskTableViewController.h
//  TaskManager
//
//  Created by Victor Macintosh on 10/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "List.h"
#import "Task.h"
#import "EditableTableViewCell.h"
#import "SegmentControlTableViewCell.h"
#import "TaskService.h"

static NSString * const kTextCellIdentifier = @"TextCellIdentifier";
static NSString * const kPriorityCellIdentifier = @"PriorityCellIdentifier";

@interface EditingTaskTableViewController : UITableViewController <EditableTableViewCellDelegate, SegmentControlTableViewCellDelegate>

@property (nonatomic) NSString *text;
@property (assign, nonatomic) NSUInteger priority;
@property (nonatomic) NSArray *priorities;

- (void)done;

@end

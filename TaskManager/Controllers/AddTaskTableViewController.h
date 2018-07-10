//
//  AddTaskTableViewController.h
//  TaskManager
//
//  Created by Victor Macintosh on 10/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditingTaskTableViewController.h"

@protocol AddTaskTableViewControllerDelegate <NSObject>

- (void)addedTask:(Task *)task;

@end

@interface AddTaskTableViewController : EditingTaskTableViewController

@property (nonatomic) List *list;
@property (weak, nonatomic) id<AddTaskTableViewControllerDelegate> delegate;

@end

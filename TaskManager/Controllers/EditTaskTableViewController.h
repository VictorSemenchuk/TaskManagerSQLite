//
//  EditTaskTableViewController.h
//  TaskManager
//
//  Created by Victor Macintosh on 10/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditingTaskTableViewController.h"

@protocol EditTaskTableViewControllerDelegate <NSObject>

- (void)changedTask:(Task *)task atIndexPath:(NSIndexPath *)indexPath;

@end

@interface EditTaskTableViewController : EditingTaskTableViewController

@property (nonatomic) Task *task;
@property (nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) id<EditTaskTableViewControllerDelegate> delegate;

@end

//
//  NewListTableViewController.h
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewListTableViewControllerDelegate <NSObject>

- (void)newListAddedWithId:(NSUInteger)listId title:(NSString *)title colorId:(NSUInteger)colorId iconId:(NSUInteger)iconId;

@end

@interface NewListTableViewController : UITableViewController

@property (weak, nonatomic) id<NewListTableViewControllerDelegate> delegate;

@end

//
//  ListTableViewController.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "List.h"

@protocol ListTableViewControllerDelegate <NSObject>

- (void)wasEditedList:(List *)list;

@end

@interface ListTableViewController : UITableViewController

@property (nonatomic) NSMutableArray *tasks;
@property (nonatomic) List *list;
@property (weak, nonatomic) id<ListTableViewControllerDelegate>delegate;

- initWithList:(List *)list;

@end

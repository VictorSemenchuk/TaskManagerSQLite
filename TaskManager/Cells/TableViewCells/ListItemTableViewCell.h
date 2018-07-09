//
//  ListItemTableViewCell.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "List.h"

@interface ListItemTableViewCell : UITableViewCell

- (void)setAttributesForTask:(Task *)task andList:(List *)list;

@end

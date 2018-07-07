//
//  ListTableViewCell.h
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "List.h"

@interface ListTableViewCell : UITableViewCell

- (void)installAttributesForList:(List *)list;

@end

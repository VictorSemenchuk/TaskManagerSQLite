//
//  IconsCollectionTableViewCell.h
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionTableViewCell.h"

@protocol IconsCollectionTableViewCellDelegate <NSObject>

- (void)iconWasSelectedWithId:(NSUInteger)iconId;

@end

@interface IconsCollectionTableViewCell : CollectionTableViewCell

@property (weak, nonatomic) id<IconsCollectionTableViewCellDelegate> delegate;

@end

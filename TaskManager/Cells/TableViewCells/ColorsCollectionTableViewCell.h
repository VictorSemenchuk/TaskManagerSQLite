//
//  ColorsCollectionTableViewCell.h
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionTableViewCell.h"

@protocol ColorsCollectionTableViewCellDelegate <NSObject>

- (void)colorWasSelectedWithId:(NSUInteger)colorId;

@end

@interface ColorsCollectionTableViewCell : CollectionTableViewCell

@property (weak, nonatomic) id<ColorsCollectionTableViewCellDelegate> delegate;

@end

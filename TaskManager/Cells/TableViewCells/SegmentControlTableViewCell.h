//
//  SegmentControlTableViewCell.h
//  TaskManager
//
//  Created by Victor Macintosh on 10/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentControlTableViewCellDelegate <NSObject>

- (void)segmentedControlWasChanged:(NSUInteger)value;

@end

@interface SegmentControlTableViewCell : UITableViewCell

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UISegmentedControl *segmentedControl;
@property (weak, nonatomic) id<SegmentControlTableViewCellDelegate> delegate;

- (void)setTitle:(NSString *)title items:(NSArray *)items selectedIndex:(NSUInteger)selectedIndex;

@end

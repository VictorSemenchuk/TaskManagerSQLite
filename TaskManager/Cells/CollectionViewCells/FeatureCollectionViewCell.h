//
//  FeatureCollectionViewCell.h
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const containerBorderWidth = 2.0;

@interface FeatureCollectionViewCell : UICollectionViewCell

@property (nonatomic) UIView *containerView;

- (void)indicateAsSelected:(BOOL)isSelected;
- (void)setupViews;

@end

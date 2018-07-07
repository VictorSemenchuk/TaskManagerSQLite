//
//  ColorCollectionViewCell.h
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureCollectionViewCell.h"

@interface ColorCollectionViewCell : FeatureCollectionViewCell

@property (nonatomic) UIView *colorView;
@property (nonatomic) UIColor *color;

- (void)installColor:(UIColor *)color;

@end

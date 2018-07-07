//
//  IconCollectionViewCell.h
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureCollectionViewCell.h"

@interface IconCollectionViewCell : FeatureCollectionViewCell

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) NSString *imageName;

- (void)installImageWithName:(NSString *)name;

@end

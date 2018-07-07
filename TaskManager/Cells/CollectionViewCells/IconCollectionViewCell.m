//
//  IconCollectionViewCell.m
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "IconCollectionViewCell.h"

@implementation IconCollectionViewCell

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imageView;
}

- (void)installImageWithName:(NSString *)name {
    self.imageName = name;
    self.imageView.image = [UIImage imageNamed:name];
}

- (void)setupViews {
    [super setupViews];
    
    [self.containerView addSubview:self.imageView];
    [NSLayoutConstraint activateConstraints:@[[self.imageView.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor constant:containerBorderWidth + 1.0],
                                              [self.imageView.widthAnchor constraintEqualToConstant:self.containerView.bounds.size.width - (2 * (containerBorderWidth + 1.0))],
                                              [self.imageView.topAnchor constraintEqualToAnchor:self.containerView.topAnchor constant:containerBorderWidth + 1.0],
                                              [self.imageView.heightAnchor constraintEqualToConstant:self.containerView.bounds.size.width - (2 * (containerBorderWidth + 1.0))]]];
    [self layoutIfNeeded];
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
    self.imageView.clipsToBounds = YES;
}

@end

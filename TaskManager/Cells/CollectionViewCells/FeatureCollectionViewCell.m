//
//  FeatureCollectionViewCell.m
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "FeatureCollectionViewCell.h"

@implementation FeatureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.translatesAutoresizingMaskIntoConstraints = NO;
        _containerView.layer.borderWidth = containerBorderWidth;
        _containerView.backgroundColor = UIColor.whiteColor;
    }
    return _containerView;
}

- (void)setupViews {
    [self addSubview:self.containerView];
    [NSLayoutConstraint activateConstraints:@[[self.containerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                              [self.containerView.widthAnchor constraintEqualToConstant:self.bounds.size.width],
                                              [self.containerView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [self.containerView.heightAnchor constraintEqualToConstant:self.bounds.size.width]]];
    [self layoutIfNeeded];
    self.containerView.layer.cornerRadius = self.containerView.frame.size.width / 2;
    self.containerView.clipsToBounds = YES;
}

- (void)indicateAsSelected:(BOOL)isSelected; {
    self.containerView.layer.borderColor = isSelected ? UIColor.blueColor.CGColor : UIColor.clearColor.CGColor;
}

@end

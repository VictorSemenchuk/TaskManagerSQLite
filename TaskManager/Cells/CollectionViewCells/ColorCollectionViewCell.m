//
//  ColorCollectionViewCell.m
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ColorCollectionViewCell.h"

@implementation ColorCollectionViewCell

- (UIView *)colorView {
    if (!_colorView) {
        _colorView = [[UIView alloc] initWithFrame:CGRectZero];
        _colorView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _colorView;
}

- (void)installColor:(UIColor *)color {
    self.color = color;
    self.colorView.backgroundColor = color;
}

- (void)setupViews {
    [super setupViews];
    
    [self.containerView addSubview:self.colorView];
    [NSLayoutConstraint activateConstraints:@[[self.colorView.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor constant:containerBorderWidth + 1.0],
                                              [self.colorView.widthAnchor constraintEqualToConstant:self.containerView.bounds.size.width - (2 * (containerBorderWidth + 1.0))],
                                              [self.colorView.topAnchor constraintEqualToAnchor:self.containerView.topAnchor constant:containerBorderWidth + 1.0],
                                              [self.colorView.heightAnchor constraintEqualToConstant:self.containerView.bounds.size.width - (2 * (containerBorderWidth + 1.0))]]];
    self.colorView.layer.cornerRadius = (self.containerView.frame.size.width - (2 * (containerBorderWidth + 1.0))) / 2;
    self.colorView.clipsToBounds = YES;
}

@end

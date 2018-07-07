//
//  ColorCollectionViewCell.m
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ColorCollectionViewCell.h"

@interface ColorCollectionViewCell ()

- (void)setupViews;

@end

@implementation ColorCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (UIView *)colorView {
    if (!_colorView) {
        _colorView = [[UIView alloc] initWithFrame:CGRectZero];
        _colorView.translatesAutoresizingMaskIntoConstraints = NO;
        _colorView.layer.borderWidth = 2.0;
    }
    return _colorView;
}

- (void)installColor:(UIColor *)color {
    self.color = color;
    self.colorView.backgroundColor = color;
}

- (void)setupViews {
    [self addSubview:self.colorView];
    [NSLayoutConstraint activateConstraints:@[[self.colorView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                              [self.colorView.widthAnchor constraintEqualToConstant:self.bounds.size.width],
                                              [self.colorView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [self.colorView.heightAnchor constraintEqualToConstant:self.bounds.size.width]]];
    [self layoutIfNeeded];
    self.colorView.layer.cornerRadius = self.colorView.frame.size.width / 2;
    self.colorView.clipsToBounds = YES;
}

- (void)indicateAsSelected:(BOOL)isSelected; {
    self.colorView.layer.borderColor = isSelected ? UIColor.blueColor.CGColor : UIColor.clearColor.CGColor;
}

@end

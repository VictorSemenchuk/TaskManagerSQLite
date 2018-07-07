//
//  IconCollectionViewCell.m
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "IconCollectionViewCell.h"

@interface IconCollectionViewCell ()

- (void)setupViews;

@end

@implementation IconCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.layer.borderWidth = 2.0;
    }
    return _imageView;
}

- (void)installImageWithName:(NSString *)name {
    self.imageName = name;
    self.imageView.image = [UIImage imageNamed:name];
}

- (void)setupViews {
    [self addSubview:self.imageView];
    [NSLayoutConstraint activateConstraints:@[[self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                              [self.imageView.widthAnchor constraintEqualToConstant:self.bounds.size.width],
                                              [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [self.imageView.heightAnchor constraintEqualToConstant:self.bounds.size.width]]];
    [self layoutIfNeeded];
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
    self.imageView.clipsToBounds = YES;
}

- (void)indicateAsSelected:(BOOL)isSelected; {
    self.imageView.layer.borderColor = isSelected ? UIColor.blueColor.CGColor : UIColor.clearColor.CGColor;
}

@end

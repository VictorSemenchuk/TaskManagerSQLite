//
//  ListTableViewCell.m
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ListTableViewCell.h"

@interface ListTableViewCell ()

@property (nonatomic) UIImageView *iconImageView;
@property (nonatomic) UILabel *titleLabel;

- (void)setupViews;

@end

@implementation ListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (void)setupViews {
    
    [self addSubview:self.iconImageView];
    [NSLayoutConstraint activateConstraints:@[[self.iconImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10.0],
                                              [self.iconImageView.widthAnchor constraintEqualToConstant:self.bounds.size.height],
                                              [self.iconImageView.heightAnchor constraintEqualToConstant:self.bounds.size.height],
                                              [self.iconImageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]]];
    
    [self addSubview:self.titleLabel];
    [NSLayoutConstraint activateConstraints:@[[self.titleLabel.leadingAnchor constraintEqualToAnchor:self.iconImageView.trailingAnchor constant:10.0],
                                              [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10.0],
                                              [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]]];
}

- (void)installAttributesForList:(List *)list {
    self.titleLabel.text = list.title;
    UIImage *icon;
    if (list.iconId) {
        icon = [UIImage imageNamed:list.icon.path];
    } else {
        icon = [UIImage imageNamed:@"icon0"];
    }
    icon = [icon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.iconImageView.image = icon;
    self.iconImageView.tintColor = list.color.color;
}

@end

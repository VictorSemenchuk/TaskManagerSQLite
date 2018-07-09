//
//  ListItemTableViewCell.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ListItemTableViewCell.h"
#import "List.h"

@interface ListItemTableViewCell ()

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIImageView *checkImageView;

- (void)setupViews;

@end

@implementation ListItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
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

- (UIImageView *)checkImageView {
    if (!_checkImageView) {
        _checkImageView = [[UIImageView alloc] init];
        _checkImageView.translatesAutoresizingMaskIntoConstraints = NO;
        UIImage *image = [UIImage imageNamed:@"CheckIcon"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _checkImageView.image = image;
    }
    return _checkImageView;
}

- (void)setupViews {
    
    //checkImageView
    [self addSubview:self.checkImageView];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.checkImageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10.0],
                                              [self.checkImageView.widthAnchor constraintEqualToConstant:20.0],
                                              [self.checkImageView.heightAnchor constraintEqualToConstant:20.0],
                                              [self.checkImageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
                                              ]];
    
    //titleLabel
    [self addSubview:self.titleLabel];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10.0],
                                              [self.titleLabel.heightAnchor constraintEqualToConstant:20.0],
                                              [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
                                              [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]
                                              ]];
    
}

- (void)setAttributesForTask:(Task *)task andList:(List *)list {
    self.titleLabel.text = task.text;
    self.checkImageView.hidden = !task.isChecked;
    self.checkImageView.tintColor = list.color.color;
}

@end

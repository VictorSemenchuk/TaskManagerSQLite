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
@property (nonatomic) UILabel *subtitleLabel;
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

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _subtitleLabel.font = [UIFont systemFontOfSize:12.0];
        _subtitleLabel.textAlignment = NSTextAlignmentLeft;
        _subtitleLabel.textColor = UIColor.redColor;
        _subtitleLabel.text = @"Subtitle";
    }
    return _subtitleLabel;
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
    
    //stackView
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 3.0;
    
    [self addSubview:stackView];
    [NSLayoutConstraint activateConstraints:@[
                                              [stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10.0],
                                              [stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10.0],
                                              [stackView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]]];
    
    [stackView addArrangedSubview:self.titleLabel];
    [stackView addArrangedSubview:self.subtitleLabel];
    
}

- (void)setAttributesForTask:(Task *)task andList:(List *)list {
    self.titleLabel.text = task.text;
    
    self.subtitleLabel.hidden = ((task.priority > 0) && (task.priority < 4)) ? NO : YES;
    
    switch (task.priority) {
        case 1:
            self.subtitleLabel.text = @"!";
            break;
        case 2:
            self.subtitleLabel.text = @"!!";
            break;
        case 3:
            self.subtitleLabel.text = @"!!!";
            break;
        default:
            self.subtitleLabel.hidden = YES;
            break;
    }
    
    self.checkImageView.hidden = !task.isChecked;
    //self.checkImageView.tintColor = [list.color color];
}

@end

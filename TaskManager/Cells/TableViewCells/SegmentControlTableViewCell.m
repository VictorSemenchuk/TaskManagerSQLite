//
//  SegmentControlTableViewCell.m
//  TaskManager
//
//  Created by Victor Macintosh on 10/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "SegmentControlTableViewCell.h"

@interface SegmentControlTableViewCell ()

- (void)setupViews;
- (void)segmentedControllerWasChanged;

@end

@implementation SegmentControlTableViewCell

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

- (UISegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] init];
        _segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
        [_segmentedControl addTarget:self action:@selector(segmentedControllerWasChanged) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

- (void)setupViews {
    
    [self addSubview:self.titleLabel];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10.0],
                                              [self.titleLabel.heightAnchor constraintEqualToConstant:14.0],
                                              [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
                                              ]];
    
    [self addSubview:self.segmentedControl];
    [NSLayoutConstraint activateConstraints:@[
                                              [self.segmentedControl.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10.0],
                                              [self.segmentedControl.heightAnchor constraintEqualToConstant:self.bounds.size.height / 2.0],
                                              [self.segmentedControl.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
                                              [self.segmentedControl.leadingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor constant:20.0]
                                              ]];
    
}

- (void)setTitle:(NSString *)title items:(NSArray *)items selectedIndex:(NSUInteger)selectedIndex {
    self.titleLabel.text = title;
    for (int i = 0; i < [items count]; i++) {
        NSString *item = items[i];
        [self.segmentedControl insertSegmentWithTitle:item atIndex:i animated:NO];
    }
    self.segmentedControl.selectedSegmentIndex = selectedIndex < self.segmentedControl.numberOfSegments ? selectedIndex : 0;
}

- (void)segmentedControllerWasChanged {
    [self.delegate segmentedControlWasChanged:self.segmentedControl.selectedSegmentIndex];
}

@end

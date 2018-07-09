//
//  EditableTableViewCell.m
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "EditableTableViewCell.h"

@interface EditableTableViewCell ()

- (void)setupViews;

@end

@implementation EditableTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:self.bounds];
        _textField.font = [UIFont systemFontOfSize:14.0];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 10.0, 20)];
        _textField.leftView = paddingView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.placeholder = @"Title";
        [_textField addTarget:self action:@selector(didChangeText) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (void)setupViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryNone;
    [self.contentView addSubview:self.textField];
}

- (void)didChangeText {
     [self.delegate textChanged:self.textField.text];
}

@end

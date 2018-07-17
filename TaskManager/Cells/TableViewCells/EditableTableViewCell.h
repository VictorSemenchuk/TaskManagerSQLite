//
//  EditableTableViewCell.h
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditableTableViewCellDelegate

- (void)textChanged:(NSString *)text;

@end

@interface EditableTableViewCell : UITableViewCell

@property (nonatomic) UITextField *textField;
@property (weak, nonatomic) id<EditableTableViewCellDelegate> delegate;

- (void)installText:(NSString *)text;

@end

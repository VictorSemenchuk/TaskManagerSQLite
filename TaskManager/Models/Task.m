//
//  Task.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "Task.h"

@implementation Task

@synthesize listId = _listId;
@synthesize taskId = _taskId;
@synthesize text = _text;
@synthesize isChecked = _isChecked;
@synthesize priority = _priority;

- (id)initWithId:(NSUInteger)taskId listId:(NSUInteger)listId text:(NSString *)text isChecked:(BOOL)isChecked priority:(NSUInteger)priority {
    self = [super init];
    if (self) {
        _listId = listId;
        _taskId = taskId;
        _text = text;
        _isChecked = isChecked;
        _priority = priority;
    }
    return self;
}

@end

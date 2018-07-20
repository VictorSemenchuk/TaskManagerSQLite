//
//  Task.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "Task.h"

@implementation Task

- (instancetype)initWithId:(NSUInteger)taskId listId:(NSUInteger)listId text:(NSString *)text isChecked:(BOOL)isChecked priority:(NSUInteger)priority {
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

- (instancetype)initWithMO:(TaskCoreData *)taskMO {
    self = [super init];
    if (self) {
        _listId = taskMO.listId;
        _taskId = taskMO.taskId;
        _text = taskMO.text;
        _isChecked = taskMO.isChecked;
        _priority = taskMO.priority;
    }
    return self;
}

@end

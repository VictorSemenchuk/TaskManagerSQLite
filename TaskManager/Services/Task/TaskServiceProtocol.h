//
//  TaskServiceProtocol.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/17/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@protocol TaskServiceProtocol <NSObject>

- (NSMutableArray *)loadTasksForListWithId:(NSUInteger)listId;
- (NSUInteger)addNewTaskWithText:(NSString *)text priority:(NSUInteger)priority andListId:(NSUInteger)listId;
- (void)updateCheckForTaskWithId:(NSUInteger)taskId oldValue:(BOOL)isChecked;
- (void)removeTaskWithId:(NSUInteger)taskId;
- (void)updateTaskWithId:(NSUInteger)taskId text:(NSString *)text priority:(NSUInteger)priority;

@end

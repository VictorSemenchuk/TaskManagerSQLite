//
//  TaskService.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseManager.h"
#import "Task.h"

@interface TaskSQLiteService : NSObject

- (NSMutableArray *)loadTasksForListWithId:(NSUInteger)listId;
- (void)addNewTaskWithText:(NSString *)text priority:(NSUInteger)priority andListId:(NSUInteger)listId;
- (void)updateCheckForTaskWithId:(NSUInteger)taskId oldValue:(BOOL)isChecked;
- (void)removeTaskWithId:(NSUInteger)taskId;
- (void)updateTaskWithId:(NSUInteger)taskId text:(NSString *)text priority:(NSUInteger)priority;

@end

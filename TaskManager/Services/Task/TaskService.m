//
//  TaskService.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/17/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "TaskService.h"
#import "AppDelegate.h"
#import "Constants.h"

@implementation TaskService

- (instancetype)init {
    self = [super init];
    if (self) {
        _taskSQLiteService = [[TaskSQLiteService alloc] init];
        _taskCoreDataService = [[TaskCoreDataService alloc] init];
        _persistentType = (PersistentType)[[NSUserDefaults standardUserDefaults] integerForKey:kPersistantTypeUserDefaultsKey];
    }
    return self;
}

#pragma mark - Adding

- (NSUInteger)addNewTaskWithText:(NSString *)text priority:(NSUInteger)priority andListId:(NSUInteger)listId {
    NSUInteger newTaskId = 0;
    newTaskId = [self.taskSQLiteService addNewTaskWithText:text priority:priority andListId:listId];
    [self.taskCoreDataService addNewTaskWithText:text priority:priority andListId:listId];
    return newTaskId;
}

#pragma mark - Loading

- (NSMutableArray *)loadTasksForListWithId:(NSUInteger)listId {
    NSMutableArray *tasks = [[NSMutableArray alloc] init];
    switch (self.persistentType) {
        case kSQLite:
            tasks = [self.taskSQLiteService loadTasksForListWithId:listId];
            break;
        case kCoreData:
            tasks = [self.taskCoreDataService loadTasksForListWithId:listId];
            break;
        default:
            break;
    }
    return tasks;
}

#pragma mark - Removing

- (void)removeTaskWithId:(NSUInteger)taskId {
    [self.taskSQLiteService removeTaskWithId:taskId];
    [self.taskCoreDataService removeTaskWithId:taskId];
}

#pragma mark - Updating

- (void)updateCheckForTaskWithId:(NSUInteger)taskId oldValue:(BOOL)isChecked {
    [self.taskSQLiteService updateCheckForTaskWithId:taskId oldValue:isChecked];
    [self.taskCoreDataService updateCheckForTaskWithId:taskId oldValue:isChecked];
}

- (void)updateTaskWithId:(NSUInteger)taskId text:(NSString *)text priority:(NSUInteger)priority {
    [self.taskSQLiteService updateTaskWithId:taskId text:text priority:priority];
    [self.taskCoreDataService updateTaskWithId:taskId text:text priority:priority];
}

@end

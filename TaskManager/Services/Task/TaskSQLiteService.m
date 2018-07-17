//
//  TaskService.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "TaskSQLiteService.h"

@implementation TaskSQLiteService

#pragma mark - Loading

- (NSMutableArray *)loadTasksForListWithId:(NSUInteger)listId {
    DatabaseManager *databaseManager = [[DatabaseManager alloc] init];
    NSMutableArray *tasks = [[NSMutableArray alloc] init];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM tasks WHERE listId = %lu", listId];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithArray:[databaseManager loadDataFromDB:query]];
    
    NSInteger indexOfId = [databaseManager.arrColumnNames indexOfObject:@"id"];
    NSInteger indexOfListId = [databaseManager.arrColumnNames indexOfObject:@"listId"];
    NSInteger indexOfText = [databaseManager.arrColumnNames indexOfObject:@"text"];
    NSInteger indexOfCheck = [databaseManager.arrColumnNames indexOfObject:@"isChecked"];
    NSInteger indexOfPriority = [databaseManager.arrColumnNames indexOfObject:@"priority"];
    
    for (int i = 0; i < [objects count]; i++) {
        Task *task = [[Task alloc] initWithId:[objects[i][indexOfId] integerValue]
                                       listId:[objects[i][indexOfListId] integerValue]
                                         text:objects[i][indexOfText]
                                    isChecked:[objects[i][indexOfCheck] boolValue]
                                     priority:[objects[i][indexOfPriority] integerValue]];
        [tasks addObject:task];
    }
    
    return tasks;
}

#pragma mark - Adding

- (NSUInteger)addNewTaskWithText:(NSString *)text priority:(NSUInteger)priority andListId:(NSUInteger)listId {
    DatabaseManager *databaseManager = [[DatabaseManager alloc] init];
    NSUInteger newTaskId = [databaseManager getLastIdForEntity:@"tasks"] + 1;
    
    NSString *query = [NSString stringWithFormat:@"INSERT INTO tasks (id, listId, text, isChecked, priority) VALUES (%lu, %lu, '%@', %d, %lu)", newTaskId, listId, text, false, priority];
    [DatabaseManager executeQuery:query];
    
    return newTaskId;
}

#pragma mark - Removing

- (void)removeTaskWithId:(NSUInteger)taskId {
    NSString *query = [NSString stringWithFormat:@"DELETE FROM tasks WHERE id = %lu", taskId];
    [DatabaseManager executeQuery:query];
}

#pragma mark - Updating

- (void)updateCheckForTaskWithId:(NSUInteger)taskId oldValue:(BOOL)isChecked {
    NSString *query = [NSString stringWithFormat:@"UPDATE tasks SET isChecked = %d WHERE id = %lu", !isChecked, taskId];
    [DatabaseManager executeQuery:query];
}

- (void)updateTaskWithId:(NSUInteger)taskId text:(NSString *)text priority:(NSUInteger)priority {
    NSString *query = [NSString stringWithFormat:@"UPDATE tasks SET text = '%@', priority = %lu WHERE id = %lu", text, priority, taskId];
    [DatabaseManager executeQuery:query];
}


@end

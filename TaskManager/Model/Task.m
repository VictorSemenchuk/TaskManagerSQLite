//
//  Task.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "Task.h"
#import "DatabaseManager.h"

@implementation Task

- (id)initWithId:(NSUInteger)taskId listId:(NSUInteger)listId text:(NSString *)text isChecked:(BOOL)isChecked {
    self = [super init];
    if (self) {
        _listId = listId;
        _taskId = taskId;
        _text = text;
        _isChecked = isChecked;
    }
    return self;
}

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

+ (NSMutableArray *)loadTasksForListWithId:(NSUInteger)listId {
    
    DatabaseManager *databaseManager = [[DatabaseManager alloc] initWithDatabaseFilename: kDatabaseFilename];
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

+ (void)addNewTaskWithText:(NSString *)text priority:(NSUInteger)priority andListId:(NSUInteger)listId {
    NSString *query = [NSString stringWithFormat:@"INSERT INTO tasks (listId, text, isChecked, priority) VALUES (%lu, '%@', %d, %lu)", listId, text, false, priority];
    [DatabaseManager executeQuery:query];
}

+ (void)updateCheckForTaskWithId:(NSUInteger)taskId oldValue:(BOOL)isChecked {
    NSString *query = [NSString stringWithFormat:@"UPDATE tasks SET isChecked = %d WHERE id = %lu", !isChecked, taskId];
    [DatabaseManager executeQuery:query];
}

+ (void)removeTaskWithId:(NSUInteger)taskId {
    NSString *query = [NSString stringWithFormat:@"DELETE FROM tasks WHERE id = %lu", taskId];
    [DatabaseManager executeQuery:query];
}

+ (void)updateTaskWithId:(NSUInteger)taskId text:(NSString *)text priority:(NSUInteger)priority {
    NSString *query = [NSString stringWithFormat:@"UPDATE tasks SET text = '%@', priority = %lu WHERE id = %lu", text, priority, taskId];
    [DatabaseManager executeQuery:query];
}

@end

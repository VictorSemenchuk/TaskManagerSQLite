//
//  Task.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "Task.h"
#import "DatabaseManager.h"

@interface Task ()

+ (void)execQuery:(NSString *)query;

@end

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

+ (NSMutableArray *)loadTasksForListWithId:(NSUInteger)listId {
    
    DatabaseManager *databaseManager = [[DatabaseManager alloc] initWithDatabaseFilename: kDatabaseFilename];
    NSMutableArray *tasks = [[NSMutableArray alloc] init];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM tasks WHERE listId = %lu", listId];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithArray:[databaseManager loadDataFromDB:query]];
    
    NSInteger indexOfId = [databaseManager.arrColumnNames indexOfObject:@"id"];
    NSInteger indexOfListId = [databaseManager.arrColumnNames indexOfObject:@"listId"];
    NSInteger indexOfText = [databaseManager.arrColumnNames indexOfObject:@"text"];
    NSInteger indexOfCheck = [databaseManager.arrColumnNames indexOfObject:@"isChecked"];
    
    for (int i = 0; i < [objects count]; i++) {
        Task *task = [[Task alloc] initWithId:[objects[i][indexOfId] integerValue]
                                       listId:[objects[i][indexOfListId] integerValue]
                                         text:objects[i][indexOfText]
                                    isChecked:[objects[i][indexOfCheck] boolValue]];
        [tasks addObject:task];
    }
    
    return tasks;
    
}

+ (void)addNewTaskWithText:(NSString *)text andListId:(NSUInteger)listId {
    NSString *query = [NSString stringWithFormat:@"INSERT INTO tasks (listId, text, isChecked) VALUES (%lu, '%@', %d)", listId, text, false];
    [Task execQuery:query];
}

+ (void)updateCheckForTaskWithId:(NSUInteger)taskId oldValue:(BOOL)isChecked {
    NSString *query = [NSString stringWithFormat:@"UPDATE tasks SET isChecked = %d WHERE id = %lu", !isChecked, taskId];
    [Task execQuery:query];
}

+ (void)execQuery:(NSString *)query {
    DatabaseManager *databaseManager = [[DatabaseManager alloc] initWithDatabaseFilename:kDatabaseFilename];
    [databaseManager executeQuery:query];
}

+ (void)removeTaskWithId:(NSUInteger)taskId {
    DatabaseManager *databaseManager = [[DatabaseManager alloc] initWithDatabaseFilename: kDatabaseFilename];
    NSString *query = [NSString stringWithFormat:@"DELETE FROM tasks WHERE id = %lu", taskId];
    [databaseManager executeQuery:query];
}

@end

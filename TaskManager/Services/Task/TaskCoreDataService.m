//
//  TaskCoreDataService.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "TaskCoreDataService.h"
#import "CoreDataManager.h"
#import "Constants.h"
#import "ListCoreDataService.h"

@implementation TaskCoreDataService

#pragma mark - Loading

- (NSMutableArray *)loadTasksForListWithId:(NSUInteger)listId {
    NSMutableArray<Task *> *tasks = [[NSMutableArray alloc] init];    
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSString *attribute = [NSString stringWithFormat:@"listId"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, listId];
    NSArray *results = [coreDataManager fetchEntitiesWithName:kTaskEntity byPredicate:predicate];
    if (results) {
        for (TaskCoreData *taskMO in results) {
            Task *task = [[Task alloc] initWithMO:taskMO];
            [tasks addObject:task];
        }
    }
    return tasks;
}

#pragma mark - Adding

- (NSUInteger)addNewTaskWithText:(NSString *)text priority:(NSUInteger)priority andListId:(NSUInteger)listId {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSUInteger taskId = 0;
    taskId = [coreDataManager addNewInstanceForEntityWithName:kTaskEntity withAssigningBlock:^(NSManagedObject *currentEntity, NSUInteger currentEntityId, NSManagedObjectContext *context) {
        [currentEntity setValue:[NSNumber numberWithInteger:currentEntityId] forKey:@"taskId"];
        [currentEntity setValue:text forKey:@"text"];
        [currentEntity setValue:[NSNumber numberWithInteger:priority] forKey:@"priority"];
        [currentEntity setValue:[NSNumber numberWithBool:NO] forKey:@"isChecked"];
        [currentEntity setValue:[NSNumber numberWithInteger:listId] forKey:@"listId"];
        
        ListCoreDataService *listCoreDataService = [[ListCoreDataService alloc] init];
        ListCoreData *list = [listCoreDataService fetchListWithId:listId inContext:context];
        [currentEntity setValue:list forKey:@"list"];
    }];
    return taskId;
}

#pragma mark - Removing

- (void)removeTaskWithId:(NSUInteger)taskId {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSString *attribute = [NSString stringWithFormat:@"taskId"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, taskId];
    [coreDataManager removeEntityWithName:kTaskEntity byPredicate:predicate];
}

#pragma mark - Updating

- (void)updateCheckForTaskWithId:(NSUInteger)taskId oldValue:(BOOL)isChecked {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSString *attribute = [NSString stringWithFormat:@"taskId"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, taskId];
    [coreDataManager updateEntityWithName:kTaskEntity byPredicate:predicate withUpdatingBlock:^(NSManagedObject *object) {
        [object setValue:[NSNumber numberWithBool:!isChecked] forKey:@"isChecked"];
    }];
}

- (void)updateTaskWithId:(NSUInteger)taskId text:(NSString *)text priority:(NSUInteger)priority {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSString *attribute = [NSString stringWithFormat:@"taskId"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, taskId];
    [coreDataManager updateEntityWithName:kTaskEntity byPredicate:predicate withUpdatingBlock:^(NSManagedObject *object) {
        [object setValue:text forKey:@"text"];
        [object setValue:[NSNumber numberWithInteger:priority] forKey:@"priority"];
    }];
}

@end

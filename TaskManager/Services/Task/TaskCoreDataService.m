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

@implementation TaskCoreDataService

#pragma mark - Loading

- (NSMutableArray *)loadTasksForListWithId:(NSUInteger)listId {
    NSMutableArray<Task *> *tasks = [[NSMutableArray alloc] init];    
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSString *attribute = [NSString stringWithFormat:@"listId%@", kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, listId];
    NSArray *results = [coreDataManager fetchEntitiesWithName:kTaskEntity byPredicate:predicate];
    if (results) {
        for (int i = 0; i < [results count]; i++) {
            NSUInteger taskId = [[results[i] valueForKey:[@"taskId" stringByAppendingString:kAttributesPostfix]] integerValue];
            NSString *text = [results[i] valueForKey:[@"text" stringByAppendingString:kAttributesPostfix]];
            NSUInteger priority = [[results[i] valueForKey:[@"priority" stringByAppendingString:kAttributesPostfix]] integerValue];
            BOOL isChecked = [[results[i] valueForKey:[@"isChecked" stringByAppendingString:kAttributesPostfix]] boolValue];
            NSUInteger listId = [[results[i] valueForKey:[@"listId" stringByAppendingString:kAttributesPostfix]] integerValue];
        
            Task *task = [[Task alloc] initWithId:taskId listId:listId text:text isChecked:isChecked priority:priority];
        
            [tasks addObject:task];
        }
    }
    return tasks;
}

#pragma mark - Adding

- (NSUInteger)addNewTaskWithText:(NSString *)text priority:(NSUInteger)priority andListId:(NSUInteger)listId {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSUInteger taskId = 0;
    taskId = [coreDataManager addNewInstanceForEntityWithName:kTaskEntity withAssigningBlock:^(NSManagedObject *currentEntity, NSUInteger currentEntityId) {
        [currentEntity setValue:[NSNumber numberWithInteger:currentEntityId] forKey:[@"taskId" stringByAppendingString:kAttributesPostfix]];
        [currentEntity setValue:text forKey:[@"text" stringByAppendingString:kAttributesPostfix]];
        [currentEntity setValue:[NSNumber numberWithInteger:priority] forKey:[@"priority" stringByAppendingString:kAttributesPostfix]];
        [currentEntity setValue:[NSNumber numberWithBool:NO] forKey:[@"isChecked" stringByAppendingString:kAttributesPostfix]];
        [currentEntity setValue:[NSNumber numberWithInteger:listId] forKey:[@"listId" stringByAppendingString:kAttributesPostfix]];
    }];
    return taskId;
}

#pragma mark - Removing

- (void)removeTaskWithId:(NSUInteger)taskId {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSString *attribute = [NSString stringWithFormat:@"taskId%@", kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, taskId];
    [coreDataManager removeEntityWithName:kTaskEntity byPredicate:predicate];
}

#pragma mark - Updating

- (void)updateCheckForTaskWithId:(NSUInteger)taskId oldValue:(BOOL)isChecked {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSString *attribute = [NSString stringWithFormat:@"taskId%@", kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, taskId];
    [coreDataManager updateEntityWithName:kTaskEntity byPredicate:predicate withUpdatingBlock:^(NSManagedObject *object) {
        [object setValue:[NSNumber numberWithBool:!isChecked] forKey:[@"isChecked" stringByAppendingString:kAttributesPostfix]];
    }];
}

- (void)updateTaskWithId:(NSUInteger)taskId text:(NSString *)text priority:(NSUInteger)priority {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSString *attribute = [NSString stringWithFormat:@"taskId%@", kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, taskId];
    [coreDataManager updateEntityWithName:kTaskEntity byPredicate:predicate withUpdatingBlock:^(NSManagedObject *object) {
        [object setValue:text forKey:[@"text" stringByAppendingString:kAttributesPostfix]];
        [object setValue:[NSNumber numberWithInteger:priority] forKey:[@"priority" stringByAppendingString:kAttributesPostfix]];
    }];
}

@end

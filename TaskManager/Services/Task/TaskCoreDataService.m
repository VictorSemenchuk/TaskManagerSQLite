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
    NSMutableArray *tasks = [[NSMutableArray alloc] init];
    
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSManagedObjectContext *context = coreDataManager.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    NSString *attribute = [NSString stringWithFormat:@"listId%@", kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, listId];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (!error) {
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
    NSManagedObjectContext *context = coreDataManager.managedObjectContext;
    
    NSUInteger newTaskId = [coreDataManager getLastIdForEntity:@"Task"] + 1;
    
    NSManagedObject *newTask = [NSEntityDescription insertNewObjectForEntityForName:kTaskEntity inManagedObjectContext:context];
    [newTask setValue:[NSNumber numberWithInteger:newTaskId] forKey:[@"taskId" stringByAppendingString:kAttributesPostfix]];
    [newTask setValue:text forKey:[@"text" stringByAppendingString:kAttributesPostfix]];
    [newTask setValue:[NSNumber numberWithInteger:priority] forKey:[@"priority" stringByAppendingString:kAttributesPostfix]];
    [newTask setValue:[NSNumber numberWithBool:NO] forKey:[@"isChecked" stringByAppendingString:kAttributesPostfix]];
    [newTask setValue:[NSNumber numberWithInteger:listId] forKey:[@"listId" stringByAppendingString:kAttributesPostfix]];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    return newTaskId;
}

#pragma mark - Removing

- (void)removeTaskWithId:(NSUInteger)taskId {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSManagedObjectContext *context = coreDataManager.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    NSString *attribute = [NSString stringWithFormat:@"taskId%@", kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, taskId];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (!error) {
        for(NSManagedObject *managedObject in results) {
            [context deleteObject:managedObject];
        }
        
        error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
}

#pragma mark - Updating

- (void)updateCheckForTaskWithId:(NSUInteger)taskId oldValue:(BOOL)isChecked {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSManagedObjectContext *context = coreDataManager.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    NSString *attribute = [NSString stringWithFormat:@"taskId%@", kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, taskId];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (!error) {
        NSManagedObject *managedObject = results.firstObject;
        [managedObject setValue:[NSNumber numberWithBool:!isChecked] forKey:[@"isChecked" stringByAppendingString:kAttributesPostfix]];
        
        error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
}

- (void)updateTaskWithId:(NSUInteger)taskId text:(NSString *)text priority:(NSUInteger)priority {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSManagedObjectContext *context = coreDataManager.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    NSString *attribute = [NSString stringWithFormat:@"taskId%@", kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, taskId];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (!error) {
        NSManagedObject *managedObject = results.firstObject;
        [managedObject setValue:text forKey:[@"text" stringByAppendingString:kAttributesPostfix]];
        [managedObject setValue:[NSNumber numberWithInteger:priority] forKey:[@"priority" stringByAppendingString:kAttributesPostfix]];
        
        error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
}

@end

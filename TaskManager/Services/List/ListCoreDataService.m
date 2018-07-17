//
//  ListCoreDataService.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ListCoreDataService.h"
#import "CoreDataManager.h"
#import "Constants.h"
#import "ColorService.h"
#import "IconService.h"

@implementation ListCoreDataService

#pragma mark - Loading

- (NSMutableArray *)loadAllLists {
    NSMutableArray *lists = [[NSMutableArray alloc] init];
    
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSManagedObjectContext *context = coreDataManager.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (!error) {
        for (int i = 0; i < [results count]; i++) {
            NSUInteger listId = [[results[i] valueForKey:[@"listId" stringByAppendingString:kAttributesPostfix]] integerValue];
            NSString *title = [results[i] valueForKey:[@"title" stringByAppendingString:kAttributesPostfix]];
            NSUInteger iconId = [[results[i] valueForKey:[@"iconId" stringByAppendingString:kAttributesPostfix]] integerValue];
            NSUInteger colorId = [[results[i] valueForKey:[@"colorId" stringByAppendingString:kAttributesPostfix]] integerValue];
            
            List *list = [[List alloc] initWithId:listId title:title iconId:iconId colorId:colorId];
            
            ColorService *colorService = [[ColorService alloc] init];
            Color *color = [colorService loadColorWithId:colorId];
            list.color = color;
            
            IconService *iconService = [[IconService alloc] init];
            Icon *icon = [iconService loadIconWithId:iconId];
            list.icon = icon;
            
            [lists addObject:list];
        }
    }
    
    return lists;
}

- (List *)loadListWithId:(NSUInteger)listId {
    List *list = [[List alloc] init];
    
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSManagedObjectContext *context = coreDataManager.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    NSString *attribute = [NSString stringWithFormat:@"listId%@", kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, listId];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (!error) {
        NSUInteger listId = [[results.firstObject valueForKey:[@"listId" stringByAppendingString:kAttributesPostfix]] integerValue];
        NSString *title = [results.firstObject valueForKey:[@"title" stringByAppendingString:kAttributesPostfix]];
        NSUInteger iconId = [[results.firstObject valueForKey:[@"iconId" stringByAppendingString:kAttributesPostfix]] integerValue];
        NSUInteger colorId = [[results.firstObject valueForKey:[@"colorId" stringByAppendingString:kAttributesPostfix]] integerValue];
        
        list = [[List alloc] initWithId:listId title:title iconId:iconId colorId:colorId];
        
        ColorService *colorService = [[ColorService alloc] init];
        Color *color = [colorService loadColorWithId:colorId];
        list.color = color;
        
        IconService *iconService = [[IconService alloc] init];
        Icon *icon = [iconService loadIconWithId:iconId];
        list.icon = icon;
    }
    
    return list;
}

#pragma mark - Adding

- (NSUInteger)addNewListWithTitle:(NSString *)title iconId:(NSUInteger)iconId colorId:(NSUInteger)colorId {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSManagedObjectContext *context = coreDataManager.managedObjectContext;
    
    NSUInteger newListId = [coreDataManager getLastIdForEntity:@"List"] + 1;
    
    NSManagedObject *newList = [NSEntityDescription insertNewObjectForEntityForName:kListEntity inManagedObjectContext:context];
    [newList setValue:[NSNumber numberWithInteger:newListId] forKey:[@"listId" stringByAppendingString:kAttributesPostfix]];
    [newList setValue:title forKey:[@"title" stringByAppendingString:kAttributesPostfix]];
    [newList setValue:[NSNumber numberWithInteger:iconId] forKey:[@"iconId" stringByAppendingString:kAttributesPostfix]];
    [newList setValue:[NSNumber numberWithInteger:colorId] forKey:[@"colorId" stringByAppendingString:kAttributesPostfix]];

//    ColorService *colorService = [[ColorService alloc] init];
//    Color *color = [colorService loadColorWithId:colorId];
//    
//    IconService *iconService = [[IconService alloc] init];
//    Icon *icon = [iconService loadIconWithId:iconId];
//    
//    [newList setValue:color forKey:@"colorVS"];
//    [newList setValue:icon forKey:@"iconVS"];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    return newListId;
}

#pragma mark - Removing

- (void)removeListWithId:(NSUInteger)listId {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSManagedObjectContext *context = coreDataManager.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    NSString *attribute = [NSString stringWithFormat:@"listId%@", kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, listId];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (!error) {
        for(NSManagedObject *object in results) {
            [context deleteObject:object];
        }
        request = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
        [request setPredicate:predicate];
        results = [context executeFetchRequest:request error:&error];
        if (!error) {
            for(NSManagedObject *object in results) {
                [context deleteObject:object];
            }
        }
        error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
            return;
        }
    } else {
        return;
    }
}

#pragma mark - Other

- (NSInteger)getCountUncheckedTasksForListId:(NSUInteger)listId { 
    NSUInteger count = 0;
    
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSManagedObjectContext *context = coreDataManager.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    NSString *firstAttribute = [NSString stringWithFormat:@"listId%@", kAttributesPostfix];
    NSString *secondAttribute = [NSString stringWithFormat:@"isChecked%@", kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K == %lu) AND (%K == %d)", firstAttribute, listId, secondAttribute, NO];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (!error) {
        count = [results count];
    }
    
    return count;
}

@end

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
    NSArray *results = [coreDataManager fetchEntitiesWithName:kListEntity byPredicate:nil];
    if (results) {
        for (ListCoreData *listMO in results) {
            List *list = [[List alloc] initWithMO:listMO];
            
            Icon *icon = [[Icon alloc] initWithMO:listMO.icon];
            list.icon = icon;
            
            Color *color = [[Color alloc] initWithMO:listMO.color];
            list.color = color;
            
            [lists addObject:list];
        }
    }
    return lists;
}

- (List *)loadListWithId:(NSUInteger)listId {
    List *list = [[List alloc] init];
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSString *attribute = [NSString stringWithFormat:@"listId"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, listId];
    NSArray *results = [coreDataManager fetchEntitiesWithName:kListEntity byPredicate:predicate];
    if (results) {
        ListCoreData *listMO = results.firstObject;
        list = [[List alloc] initWithMO:listMO];
        
        Icon *icon = [[Icon alloc] initWithMO:listMO.icon];
        list.icon = icon;
        
        Color *color = [[Color alloc] initWithMO:listMO.color];
        list.color = color;
    }
    return list;
}

- (ListCoreData *)fetchListWithId:(NSUInteger)listId inContext:(NSManagedObjectContext *)context {
    ListCoreData *list = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:kListEntity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"listId == %lu", listId];
    [request setPredicate: predicate];
    NSArray *results = [context executeFetchRequest:request error:nil];
    if (results) {
        list = [results firstObject];
    }
    return list;
}

#pragma mark - Adding

- (NSUInteger)addNewListWithTitle:(NSString *)title iconId:(NSUInteger)iconId colorId:(NSUInteger)colorId {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSUInteger listId = 0;
    listId = [coreDataManager addNewInstanceForEntityWithName:kListEntity withAssigningBlock:^(NSManagedObject *currentEntity, NSUInteger currentEntityId, NSManagedObjectContext *context) {
        [currentEntity setValue:[NSNumber numberWithInteger:currentEntityId] forKey:@"listId"];
        [currentEntity setValue:title forKey:@"title"];
        [currentEntity setValue:[NSNumber numberWithInteger:iconId] forKey:@"iconId"];
        [currentEntity setValue:[NSNumber numberWithInteger:colorId] forKey:@"colorId"];
        
        IconCoreDataService *iconCoreDataService = [[IconCoreDataService alloc] init];
        IconCoreData *icon = [iconCoreDataService fetchIconWithId:iconId inContext:context];
        [currentEntity setValue:icon forKey:@"icon"];
        
        ColorCoreDataService *colorCoreDataService = [[ColorCoreDataService alloc] init];
        ColorCoreData *color = [colorCoreDataService fetchColorWithId:colorId inContext:context];
        [currentEntity setValue:color forKey:@"color"];
    }];
    return listId;
}

#pragma mark - Removing

- (void)removeListWithId:(NSUInteger)listId {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSString *attribute = [NSString stringWithFormat:@"listId"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, listId];
    int resultCode = [coreDataManager removeEntityWithName:kListEntity byPredicate:predicate];
    if (resultCode == 0) {
        [coreDataManager removeEntityWithName:kTaskEntity byPredicate:predicate];
    }
}

#pragma mark - Other

- (NSInteger)getCountUncheckedTasksForListId:(NSUInteger)listId { 
    NSUInteger count = 0;
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSString *firstAttribute = [NSString stringWithFormat:@"listId"];
    NSString *secondAttribute = [NSString stringWithFormat:@"isChecked"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K == %lu) AND (%K == %d)", firstAttribute, listId, secondAttribute, NO];
    NSArray *results = [coreDataManager fetchEntitiesWithName:kTaskEntity byPredicate:predicate];
    if (results) {
        count = [results count];
    }
    return count;
}

@end

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
    NSString *attribute = [NSString stringWithFormat:@"listId%@", kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, listId];
    NSArray *results = [coreDataManager fetchEntitiesWithName:kListEntity byPredicate:predicate];
    if (results) {
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
    NSUInteger listId = 0;
    listId = [coreDataManager addNewInstanceForEntityWithName:kListEntity withAssigningBlock:^(NSManagedObject *currentEntity, NSUInteger currentEntityId) {
        [currentEntity setValue:[NSNumber numberWithInteger:currentEntityId] forKey:[@"listId" stringByAppendingString:kAttributesPostfix]];
        [currentEntity setValue:title forKey:[@"title" stringByAppendingString:kAttributesPostfix]];
        [currentEntity setValue:[NSNumber numberWithInteger:iconId] forKey:[@"iconId" stringByAppendingString:kAttributesPostfix]];
        [currentEntity setValue:[NSNumber numberWithInteger:colorId] forKey:[@"colorId" stringByAppendingString:kAttributesPostfix]];
    }];
    return listId;
}

#pragma mark - Removing

- (void)removeListWithId:(NSUInteger)listId {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSString *attribute = [NSString stringWithFormat:@"listId%@", kAttributesPostfix];
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
    NSString *firstAttribute = [NSString stringWithFormat:@"listId%@", kAttributesPostfix];
    NSString *secondAttribute = [NSString stringWithFormat:@"isChecked%@", kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K == %lu) AND (%K == %d)", firstAttribute, listId, secondAttribute, NO];
    NSArray *results = [coreDataManager fetchEntitiesWithName:kTaskEntity byPredicate:predicate];
    if (results) {
        count = [results count];
    }
    return count;
}

@end

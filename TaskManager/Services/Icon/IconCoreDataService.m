//
//  IconCoreDataService.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "IconCoreDataService.h"
#import "CoreDataManager.h"
#import "Constants.h"

@implementation IconCoreDataService

#pragma mark - Adding

- (void)addIconWithPath:(NSString *)path andIconId:(NSUInteger)iconId {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    [coreDataManager addNewInstanceForEntityWithName:kIconEntity withAssigningBlock:^(NSManagedObject *currentEntity, NSUInteger currentEntityId, NSManagedObjectContext *context) {
        [currentEntity setValue:[NSNumber numberWithInteger:iconId] forKey:@"iconId"];
        [currentEntity setValue:path forKey:@"path"];
    }];
}

#pragma mark - Loading

- (NSMutableArray *)loadAllIcons {
    NSMutableArray *icons = [[NSMutableArray alloc] init];
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSArray *results = [coreDataManager fetchEntitiesWithName:kIconEntity byPredicate:nil];
    if (results) {
        for (IconCoreData *iconMO in results) {
            Icon *icon = [[Icon alloc] initWithMO:iconMO];
            [icons addObject:icon];
        }
    }
    return icons;
}

- (Icon *)loadIconWithId:(NSUInteger)iconId {
    Icon *icon = [[Icon alloc] init];
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSString *attribute = [NSString stringWithFormat:@"iconId"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, iconId];
    NSArray *results = [coreDataManager fetchEntitiesWithName:kIconEntity byPredicate:predicate];
    if (results) {
        IconCoreData *iconMO = results.firstObject;
        icon = [[Icon alloc] initWithMO:iconMO];
    }
    return icon;
}

- (IconCoreData *)fetchIconWithId:(NSUInteger)iconId inContext:(NSManagedObjectContext *)context {
    IconCoreData *icon = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:kIconEntity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"iconId == %lu", iconId];
    [request setPredicate:predicate];
    NSArray *results = [context executeFetchRequest:request error:nil];
    if (results) {
        icon = results.firstObject;
    }
    return icon;
}

@end

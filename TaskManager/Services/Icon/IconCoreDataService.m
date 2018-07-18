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
    [coreDataManager addNewInstanceForEntityWithName:kIconEntity withAssigningBlock:^(NSManagedObject *currentEntity, NSUInteger currentEntityId) {
        [currentEntity setValue:[NSNumber numberWithInteger:iconId] forKey:[@"iconId" stringByAppendingString:kAttributesPostfix]];
        [currentEntity setValue:path forKey:[@"path" stringByAppendingString:kAttributesPostfix]];
    }];
}

#pragma mark - Loading

- (NSMutableArray *)loadAllIcons {
    NSMutableArray *icons = [[NSMutableArray alloc] init];
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSArray *results = [coreDataManager fetchEntitiesWithName:kIconEntity byPredicate:nil];
    if (results) {
        for (int i = 0; i < [results count]; i++) {
            NSUInteger iconId = [[results[i] valueForKey:[@"iconId" stringByAppendingString:kAttributesPostfix]] integerValue];
            NSString *path = [results[i] valueForKey:[@"path" stringByAppendingString:kAttributesPostfix]];
            Icon *icon = [[Icon alloc] initWithId:iconId andPath:path];
            [icons addObject:icon];
        }
    }
    return icons;
}

- (Icon *)loadIconWithId:(NSUInteger)iconId {
    Icon *icon = [[Icon alloc] init];
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSString *attribute = [NSString stringWithFormat:@"iconId%@", kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, iconId];
    NSArray *results = [coreDataManager fetchEntitiesWithName:kIconEntity byPredicate:predicate];
    if (results) {
        NSUInteger iconId = [[results.firstObject valueForKey:[@"iconId" stringByAppendingString:kAttributesPostfix]] integerValue];
        NSString *path = [results.firstObject valueForKey:[@"path" stringByAppendingString:kAttributesPostfix]];
        icon = [[Icon alloc] initWithId:iconId andPath:path];
    }
    return icon;
}

@end

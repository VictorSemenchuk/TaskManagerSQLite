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
    NSManagedObjectContext *context = coreDataManager.managedObjectContext;
    
    NSManagedObject *newIcon = [NSEntityDescription insertNewObjectForEntityForName:kIconEntity inManagedObjectContext:context];
    [newIcon setValue:[NSNumber numberWithInteger:iconId] forKey:[@"iconId" stringByAppendingString:kAttributesPostfix]];
    [newIcon setValue:path forKey:[@"path" stringByAppendingString:kAttributesPostfix]];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

#pragma mark - Loading

- (NSMutableArray *)loadAllIcons {
    NSMutableArray *icons = [[NSMutableArray alloc] init];
    
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSManagedObjectContext *context = coreDataManager.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Icon"];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (!error) {
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
    NSManagedObjectContext *context = coreDataManager.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Icon"];
    NSString *attribute = [NSString stringWithFormat:@"iconId%@", kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, iconId];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (!error) {
        NSUInteger iconId = [[results.firstObject valueForKey:[@"iconId" stringByAppendingString:kAttributesPostfix]] integerValue];
        NSString *path = [results.firstObject valueForKey:[@"path" stringByAppendingString:kAttributesPostfix]];
        
        icon = [[Icon alloc] initWithId:iconId andPath:path];
    }
    
    return icon;
}


@end

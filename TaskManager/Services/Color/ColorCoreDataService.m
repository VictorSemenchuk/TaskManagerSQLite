//
//  ColorCoreDataService.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ColorCoreDataService.h"
#import "CoreDataManager.h"
#import "Constants.h"

@implementation ColorCoreDataService

#pragma mark - Adding

- (void)addColorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha colorId:(NSUInteger)colorId {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    [coreDataManager addNewInstanceForEntityWithName:kColorEntity withAssigningBlock:^(NSManagedObject *currentEntity, NSUInteger currentEntityId, NSManagedObjectContext *context) {
        [currentEntity setValue:[NSNumber numberWithInteger:colorId] forKey:@"colorId"];
        [currentEntity setValue:[NSNumber numberWithInteger:red] forKey:@"red"];
        [currentEntity setValue:[NSNumber numberWithInteger:green] forKey:@"green"];
        [currentEntity setValue:[NSNumber numberWithInteger:blue] forKey:@"blue"];
        [currentEntity setValue:[NSNumber numberWithInteger:alpha] forKey:@"alpha"];
    }];
}

#pragma mark - Loading

- (NSMutableArray *)loadAllColors {
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSArray *results = [coreDataManager fetchEntitiesWithName:kColorEntity byPredicate:nil];
    if (results) {
        for (ColorCoreData *colorMO in results) {
            Color *color = [[Color alloc] initWithMO:colorMO];
            [colors addObject:color];
        }
    }
    return colors;
}

- (Color *)loadColorWithId:(NSUInteger)colorId {
    Color *color = [[Color alloc] init];
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSString *attribute = [NSString stringWithFormat:@"colorId"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, colorId];
    NSArray *results = [coreDataManager fetchEntitiesWithName:kColorEntity byPredicate:predicate];
    if (results) {
            ColorCoreData *colorMO = results.firstObject;
            color = [[Color alloc] initWithMO:colorMO];
    }
    return color;
}

- (ColorCoreData *)fetchColorWithId:(NSUInteger)colorId inContext:(NSManagedObjectContext *)context {
    ColorCoreData *color = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:kColorEntity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"colorId == %lu", colorId];
    [request setPredicate:predicate];
    NSArray *results = [context executeFetchRequest:request error:nil];
    if (results) {
        color = results.firstObject;
    }
    return color;
}

@end

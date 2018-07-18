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
    [coreDataManager addNewInstanceForEntityWithName:kColorEntity withAssigningBlock:^(NSManagedObject *currentEntity, NSUInteger currentEntityId) {
        [currentEntity setValue:[NSNumber numberWithInteger:colorId] forKey:[@"colorId" stringByAppendingString:kAttributesPostfix]];
        [currentEntity setValue:[NSNumber numberWithInteger:red] forKey:[@"red" stringByAppendingString:kAttributesPostfix]];
        [currentEntity setValue:[NSNumber numberWithInteger:green] forKey:[@"green" stringByAppendingString:kAttributesPostfix]];
        [currentEntity setValue:[NSNumber numberWithInteger:blue] forKey:[@"blue" stringByAppendingString:kAttributesPostfix]];
        [currentEntity setValue:[NSNumber numberWithInteger:alpha] forKey:[@"alpha" stringByAppendingString:kAttributesPostfix]];
    }];
}

#pragma mark - Loading

- (NSMutableArray *)loadAllColors {
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSArray *results = [coreDataManager fetchEntitiesWithName:kColorEntity byPredicate:nil];
    if (results) {
        for (int i = 0; i < [results count]; i++) {
            NSUInteger colorId = [[results[i] valueForKey:[@"colorId" stringByAppendingString:kAttributesPostfix]] integerValue];
            NSUInteger red = [[results[i] valueForKey:[@"red" stringByAppendingString:kAttributesPostfix]] integerValue];
            NSUInteger green = [[results[i] valueForKey:[@"green" stringByAppendingString:kAttributesPostfix]] integerValue];
            NSUInteger blue = [[results[i] valueForKey:[@"blue" stringByAppendingString:kAttributesPostfix]] integerValue];
            NSUInteger alpha = [[results[i] valueForKey:[@"alpha" stringByAppendingString:kAttributesPostfix]] integerValue];
            Color *color = [[Color alloc] initWithId:colorId red:red green:green blue:blue alpha:alpha];
            [colors addObject:color];
        }
    }
    return colors;
}

- (Color *)loadColorWithId:(NSUInteger)colorId {
    Color *color = [[Color alloc] init];
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSString *attribute = [NSString stringWithFormat:@"colorId%@", kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, colorId];
    NSArray *results = [coreDataManager fetchEntitiesWithName:kColorEntity byPredicate:predicate];
    if (results) {
            NSUInteger colorId = [[results.firstObject valueForKey:[@"colorId" stringByAppendingString:kAttributesPostfix]] integerValue];
            NSUInteger red = [[results.firstObject valueForKey:[@"red" stringByAppendingString:kAttributesPostfix]] integerValue];
            NSUInteger green = [[results.firstObject valueForKey:[@"green" stringByAppendingString:kAttributesPostfix]] integerValue];
            NSUInteger blue = [[results.firstObject valueForKey:[@"blue" stringByAppendingString:kAttributesPostfix]] integerValue];
            NSUInteger alpha = [[results.firstObject valueForKey:[@"alpha" stringByAppendingString:kAttributesPostfix]] integerValue];
            color = [[Color alloc] initWithId:colorId red:red green:green blue:blue alpha:alpha];
    }
    return color;
}

@end

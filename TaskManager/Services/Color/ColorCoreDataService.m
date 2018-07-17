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
    NSManagedObjectContext *context = coreDataManager.managedObjectContext;
    
    NSManagedObject *newColor = [NSEntityDescription insertNewObjectForEntityForName:kColorEntity inManagedObjectContext:context];
    [newColor setValue:[NSNumber numberWithInteger:colorId] forKey:[@"colorId" stringByAppendingString:kAttributesPostfix]];
    [newColor setValue:[NSNumber numberWithInteger:red] forKey:[@"red" stringByAppendingString:kAttributesPostfix]];
    [newColor setValue:[NSNumber numberWithInteger:green] forKey:[@"green" stringByAppendingString:kAttributesPostfix]];
    [newColor setValue:[NSNumber numberWithInteger:blue] forKey:[@"blue" stringByAppendingString:kAttributesPostfix]];
    [newColor setValue:[NSNumber numberWithInteger:alpha] forKey:[@"alpha" stringByAppendingString:kAttributesPostfix]];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

#pragma mark - Loading

- (NSMutableArray *)loadAllColors {
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSManagedObjectContext *context = coreDataManager.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Color"];

    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (!error) {
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
    NSManagedObjectContext *context = coreDataManager.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Color"];
    NSString *attribute = [NSString stringWithFormat:@"colorId%@", kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %lu", attribute, colorId];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (!error) {
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

//
//  ColorService.m
//  TaskManager
//
//  Created by Victor Macintosh on 16/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ColorService.h"
#import "AppDelegate.h"
#import "Constants.h"

@implementation ColorService

- (instancetype)init {
    self = [super init];
    if (self) {
        _colorSQLiteService = [[ColorSQLiteService alloc] init];
        _colorCoreDataService = [[ColorCoreDataService alloc] init];
        _persistentType = (PersistentType)[[NSUserDefaults standardUserDefaults] integerForKey:kPersistantTypeUserDefaultsKey];
    }
    return self;
}

#pragma mark - Adding

- (void)addColorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha colorId:(NSUInteger)colorId {
    [self.colorSQLiteService addColorWithRed:red green:green blue:blue alpha:alpha colorId:colorId];
    [self.colorCoreDataService addColorWithRed:red green:green blue:blue alpha:alpha colorId:colorId];
}

#pragma mark - Loading

- (NSMutableArray *)loadAllColors {
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    switch (self.persistentType) {
        case kSQLite:
            colors = [self.colorSQLiteService loadAllColors];
            break;
        case kCoreData:
            colors = [self.colorCoreDataService loadAllColors];
            break;
        default:
            break;
    }
    return colors;
}

- (Color *)loadColorWithId:(NSUInteger)colorId {
    Color *color = [[Color alloc] init];
    switch (self.persistentType) {
        case kSQLite:
            color = [self.colorSQLiteService loadColorWithId:colorId];
            break;
        case kCoreData:
            color = [self.colorCoreDataService loadColorWithId:colorId];
            break;
        default:
            break;
    }
    return color;
}

@end

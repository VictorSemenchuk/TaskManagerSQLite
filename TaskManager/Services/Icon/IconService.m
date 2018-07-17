//
//  IconService.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/17/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "IconService.h"
#import "AppDelegate.h"
#import "Constants.h"

@implementation IconService

- (instancetype)init {
    self = [super init];
    if (self) {
        _iconSQLiteService = [[IconSQLiteService alloc] init];
        _iconCoreDataService = [[IconCoreDataService alloc] init];
        _persistentType = (PersistentType)[[NSUserDefaults standardUserDefaults] integerForKey:kPersistantTypeUserDefaultsKey];
    }
    return self;
}

#pragma mark - Adding

- (void)addIconWithPath:(NSString *)path andIconId:(NSUInteger)iconId {
    [self.iconSQLiteService addIconWithPath:path andIconId:iconId];
    [self.iconCoreDataService addIconWithPath:path andIconId:iconId];
}

#pragma mark - Loading

- (NSMutableArray *)loadAllIcons {
    NSMutableArray *icons = [[NSMutableArray alloc] init];
    switch (self.persistentType) {
        case kSQLite:
            icons = [self.iconSQLiteService loadAllIcons];
            break;
        case kCoreData:
            icons = [self.iconCoreDataService loadAllIcons];
            break;
        default:
            break;
    }
    return icons;
}

- (Icon *)loadIconWithId:(NSUInteger)iconId {
    Icon *icon = [[Icon alloc] init];
    switch (self.persistentType) {
        case kSQLite:
            icon = [self.iconSQLiteService loadIconWithId:iconId];
            break;
        case kCoreData:
            icon = [self.iconCoreDataService loadIconWithId:iconId];
            break;
        default:
            break;
    }
    return icon;
}

@end

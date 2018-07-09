//
//  Icon.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "Icon.h"
#import "DatabaseManager.h"

@interface Icon ()

+ (NSMutableArray *)loadDataWithQuery:(NSString *)query;

@end

@implementation Icon

- (id)initWithId:(NSUInteger)iconId andPath:(NSString *)path {
    self = [super init];
    if (self) {
        _iconId = iconId;
        _path = path;
    }
    return self;
}

+ (void)addIconWithPath:(NSString *)path {
    DatabaseManager *databaseManager = [[DatabaseManager alloc] initWithDatabaseFilename:kDatabaseFilename];
    NSString *query = [NSString stringWithFormat:@"INSERT INTO icons (path) VALUES ('%@')", path];
    [databaseManager executeQuery:query];
}

+ (NSMutableArray *)loadAllIcons {
    NSString *query = @"SELECT * FROM icons";
    NSMutableArray *icons = [Icon loadDataWithQuery:query];
    return icons;
}

+ (Icon *)loadIconWithId:(NSUInteger)iconId {
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM icons WHERE id = %lu", iconId];
    Icon* icon = [Icon loadDataWithQuery:query][0];
    return icon;
}

+ (NSMutableArray *)loadDataWithQuery:(NSString *)query {
    
    DatabaseManager *databaseManager = [[DatabaseManager alloc] initWithDatabaseFilename:kDatabaseFilename];
    NSMutableArray *icons = [[NSMutableArray alloc] init];

    NSMutableArray *objects = [[NSMutableArray alloc] initWithArray:[databaseManager loadDataFromDB:query]];
    
    NSInteger indexOfId = [databaseManager.arrColumnNames indexOfObject:@"id"];
    NSInteger indexOfPath = [databaseManager.arrColumnNames indexOfObject:@"path"];
    
    for(int i = 0; i < [objects count]; i++) {
        Icon *icon = [[Icon alloc] initWithId:[objects[i][indexOfId] integerValue]
                                      andPath:objects[i][indexOfPath]];
        [icons addObject:icon];
    }
    
    return icons;
    
}

@end

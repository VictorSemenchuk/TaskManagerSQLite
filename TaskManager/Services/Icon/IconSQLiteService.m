//
//  IconService.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "IconSQLiteService.h"

@interface IconSQLiteService ()

- (NSMutableArray *)loadDataWithQuery:(NSString *)query;

@end

@implementation IconSQLiteService

- (void)addIconWithPath:(NSString *)path {
    NSString *query = [NSString stringWithFormat:@"INSERT INTO icons (path) VALUES ('%@')", path];
    [DatabaseManager executeQuery:query];
}

- (NSMutableArray *)loadAllIcons {
    NSString *query = @"SELECT * FROM icons";
    NSMutableArray *icons = [self loadDataWithQuery:query];
    return icons;
}

- (Icon *)loadIconWithId:(NSUInteger)iconId {
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM icons WHERE id = %lu", iconId];
    Icon* icon = [self loadDataWithQuery:query][0];
    return icon;
}

- (NSMutableArray *)loadDataWithQuery:(NSString *)query {
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

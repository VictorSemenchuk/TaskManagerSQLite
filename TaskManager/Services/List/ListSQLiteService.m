//
//  ListService.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ListSQLiteService.h"
#import "ColorSQLiteService.h"
#import "IconSQLiteService.h"

@interface ListSQLiteService ()

- (NSMutableArray *)loadDataWithQuery:(NSString *)query;

@end

@implementation ListSQLiteService

- (void)addNewListWithTitle:(NSString *)title iconId:(NSUInteger)iconId colorId:(NSUInteger)colorId {
    NSString *query = [NSString stringWithFormat:@"INSERT INTO lists (title, colorId, iconId) VALUES ('%@', %lu, %lu)", title, colorId, iconId];
    [DatabaseManager executeQuery:query];
}

- (NSMutableArray *)loadAllLists {
    NSString *query = @"SELECT * FROM lists";
    NSMutableArray *lists = [self loadDataWithQuery:query];
    return lists;
}

- (List *)loadListWithId:(NSUInteger)listId {
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM lists WHERE id = %lu", listId];
    List* list = [self loadDataWithQuery:query][0];
    return list;
}

- (NSMutableArray *)loadDataWithQuery:(NSString *)query {
    DatabaseManager *databaseManager = [[DatabaseManager alloc] initWithDatabaseFilename: kDatabaseFilename];
    NSMutableArray *lists = [[NSMutableArray alloc] init];
    
    NSMutableArray *objects = [[NSMutableArray alloc] initWithArray:[databaseManager loadDataFromDB:query]];
    
    NSInteger indexOfId = [databaseManager.arrColumnNames indexOfObject:@"id"];
    NSInteger indexOfTitle = [databaseManager.arrColumnNames indexOfObject:@"title"];
    NSInteger indexOfColorId = [databaseManager.arrColumnNames indexOfObject:@"colorId"];
    NSInteger indexOfIconId = [databaseManager.arrColumnNames indexOfObject:@"iconId"];
    
    for (int i = 0; i < [objects count]; i++) {
        List *list = [[List alloc] initWithId:[objects[i][indexOfId] integerValue]
                                        title:objects[i][indexOfTitle]
                                       iconId:[objects[i][indexOfIconId] integerValue]
                                      colorId:[objects[i][indexOfColorId] integerValue]];
        
        ColorSQLiteService *colorSQLiteService = [[ColorSQLiteService alloc] init];
        list.color = [colorSQLiteService loadColorWithId:list.colorId];
        
        IconSQLiteService *iconSQLiteService = [[IconSQLiteService alloc] init];
        list.icon = [iconSQLiteService loadIconWithId:list.iconId];
        
        [lists addObject:list];
    }
    
    return lists;
}

- (void)removeListWithId:(NSUInteger)listId {
    NSString *query = [NSString stringWithFormat:@"DELETE FROM tasks WHERE listId = %lu", listId];
    [DatabaseManager executeQuery:query];
    query = [NSString stringWithFormat:@"DELETE FROM lists WHERE id = %lu", listId];
    [DatabaseManager executeQuery:query];
}

- (NSInteger)getCountUncheckedTasksForListId:(NSUInteger)listId {
    DatabaseManager *databaseManager = [[DatabaseManager alloc] initWithDatabaseFilename:kDatabaseFilename];
    NSString *query = [NSString stringWithFormat:@"SELECT COUNT(id) FROM tasks WHERE listId = %lu AND isChecked = %d", listId, false];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithArray:[databaseManager loadDataFromDB:query]];
    NSUInteger count = 0;
    
    if ([objects count] != 0) {
        count = [[objects firstObject][0] integerValue];
    }
    
    return count;
}

@end

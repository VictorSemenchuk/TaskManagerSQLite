//
//  List.m
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "List.h"
#import "DatabaseManager.h"

@interface List ()

+ (NSMutableArray *)loadDataWithQuery:(NSString *)query;

@end

@implementation List

- (id)initWithId:(NSUInteger)listId title:(NSString *)title iconId:(NSUInteger)iconId colorId:(NSUInteger)colorId {
    self = [super init];
    if (self) {
        _listId = listId;
        _title = title;
        _iconId = iconId;
        _colorId = colorId;

        _color = [Color loadColorWithId:colorId];
        _icon = [Icon loadIconWithId:iconId];
    }
    return self;
}

+ (void)addNewListWithTitle:(NSString *)title iconId:(NSUInteger)iconId colorId:(NSUInteger)colorId {
    DatabaseManager *databaseManager = [[DatabaseManager alloc] initWithDatabaseFilename:kDatabaseFilename];
    NSString *query = [NSString stringWithFormat:@"INSERT INTO lists (title, colorId, iconId) VALUES ('%@', %lu, %lu)", title, colorId, iconId];
    [databaseManager executeQuery:query];
}

+ (NSMutableArray *)loadAllLists {
    NSString *query = @"SELECT * FROM lists";
    NSMutableArray *lists = [List loadDataWithQuery:query];
    return lists;
}

+ (List *)loadListWithId:(NSUInteger)listId {
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM lists WHERE id = %lu", listId];
    List* list = [List loadDataWithQuery:query][0];
    return list;
}

+ (NSMutableArray *)loadDataWithQuery:(NSString *)query {
    
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
        [lists addObject:list];
    }
    
    return lists;
}

+ (void)removeListWithId:(NSUInteger)listId {
    DatabaseManager *databaseManager = [[DatabaseManager alloc] initWithDatabaseFilename: kDatabaseFilename];
    NSString *query = [NSString stringWithFormat:@"DELETE FROM tasks WHERE listId = %lu", listId];
    [databaseManager executeQuery:query];
    query = [NSString stringWithFormat:@"DELETE FROM lists WHERE id = %lu", listId];
    [databaseManager executeQuery:query];
}

@end

//
//  List+CoreDataClass.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//
//

#import "List+CoreDataClass.h"

@implementation List

- (NSMutableArray *)loadAllListsFrom:(PersistentType)persistentType {
    NSMutableArray *lists;
    switch (persistentType) {
        case kSQLite:
            lists = [NSMutableArray arrayWithArray:[List loadDataWithQuery:@"SELECT * FROM lists"]];
            List load
            break;
        case kCoreData:
            break;
        default:
            break;
    }
    return lists;
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
        list.listId = [objects[i][indexOfId] integerValue];
        list.title = objects[i][indexOfTitle];
        list.iconId = [objects[i][indexOfIconId] integerValue];
        list.colorId = [objects[i][indexOfColorId] integerValue];
        
        [lists addObject:list];
    }
    
    return lists;
}

@end

//
//  ListService.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/17/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ListService.h"
#import "Constants.h"

@implementation ListService

- (instancetype)init {
    self = [super init];
    if (self) {
        _listSQLiteService = [[ListSQLiteService alloc] init];
        _listCoreDataService = [[ListCoreDataService alloc] init];
        _persistentType = (PersistentType)[[NSUserDefaults standardUserDefaults] integerForKey:kPersistantTypeUserDefaultsKey];
    }
    return self;
}

#pragma mark - Adding

- (NSUInteger)addNewListWithTitle:(NSString *)title iconId:(NSUInteger)iconId colorId:(NSUInteger)colorId {
    NSUInteger newListId = 0;
    newListId = [self.listSQLiteService addNewListWithTitle:title iconId:iconId colorId:colorId];
    [self.listCoreDataService addNewListWithTitle:title iconId:iconId colorId:colorId];
    return newListId;
}

#pragma mark - Loading

- (NSMutableArray *)loadAllLists {
    NSMutableArray *lists = [[NSMutableArray alloc] init];
    switch (self.persistentType) {
        case kSQLite:
            lists = [self.listSQLiteService loadAllLists];
            break;
        case kCoreData:
            lists = [self.listCoreDataService loadAllLists];
            break;
        default:
            break;
    }
    return lists;
}

- (List *)loadListWithId:(NSUInteger)listId {
    List *list = [[List alloc] init];
    switch (self.persistentType) {
        case kSQLite:
            list = [self.listSQLiteService loadListWithId:listId];
            break;
        case kCoreData:
            list = [self.listCoreDataService loadListWithId:listId];
            break;
        default:
            break;
    }
    return list;
}

#pragma mark - Removing

- (void)removeListWithId:(NSUInteger)listId {
    [self.listSQLiteService removeListWithId:listId];
    [self.listCoreDataService removeListWithId:listId];
}

#pragma mark - Other

- (NSInteger)getCountUncheckedTasksForListId:(NSUInteger)listId {
    NSUInteger count = 0;
    switch (self.persistentType) {
        case kSQLite:
            count = [self.listSQLiteService getCountUncheckedTasksForListId:listId];
            break;
        case kCoreData:
            count = [self.listCoreDataService getCountUncheckedTasksForListId:listId];
            break;
        default:
            break;
    }
    return count;
}

@end

//
//  DatabaseManager.h
//  TaskManager
//
//  Created by Victor Macintosh on 08/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kDatabaseFilename = @"TaskManager.sqlite";

typedef enum {
    kSQLite,
    kCoreData
} PersistentType;

@interface DatabaseManager : NSObject

@property (nonatomic) NSMutableArray *arrColumnNames;

- (id)initWithDatabaseFilename:(NSString *)dbFilename;
- (NSArray *)loadDataFromDB:(NSString *)query;
- (void)executeQuery:(NSString *)query;
+ (void)executeQuery:(NSString *)query;
+ (NSUInteger)getLastIdForList:(NSString *)query;

@end

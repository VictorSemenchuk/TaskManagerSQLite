//
//  DatabaseManager.m
//  TaskManager
//
//  Created by Victor Macintosh on 08/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "DatabaseManager.h"
#import <sqlite3.h>
#import "ColorService.h"
#import "IconService.h"

static NSString * const kDatabaseFilename = @"TaskManagerSQLite.sqlite";

@interface DatabaseManager ()

@property (nonatomic) NSString *documentsDirectory;
@property (nonatomic) NSMutableArray *arrResults;

- (void)createDatabaseIfNeeded;
- (NSUInteger)createTableWithName:(NSString *)tableName query:(NSString *)query database:(sqlite3 *)database;
- (void)fillInitialData;
- (void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;
- (void)runNonExecutableQuery:(sqlite3_stmt *)compiledStatement db:(sqlite3 *)db;
- (void)runExecutableQuery:(sqlite3_stmt *)compiledStatement db:(sqlite3 *)db;
- (void)setupArrays;

@end

@implementation DatabaseManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        [self createDatabaseIfNeeded];
    }
    return self;
}

#pragma mark - Creating database

- (void)createDatabaseIfNeeded {
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:kDatabaseFilename];
    NSLog(@"Database destination path: %@", destinationPath);
    sqlite3 *database;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if ([fileManager fileExistsAtPath:destinationPath isDirectory:nil]) {
        NSLog(@"Database already exists");
        return;
    }
    if (sqlite3_open([destinationPath UTF8String], &database) == SQLITE_OK) {
        NSUInteger resultCode = 0;
        NSString *query = @"CREATE TABLE lists (id integer PRIMARY KEY, title text NOT NULL, colorId integer NOT NULL, iconId integer NOT NULL)";
        resultCode = [self createTableWithName:@"lists" query:query database:database];
        if (resultCode == 1) {
            sqlite3_close(database);
            return;
        }
        query = @"CREATE TABLE tasks (id integer PRIMARY KEY, listId integet NOT NULL, text text NOT NULL, isChecked boolean NOT NULL, priority integer NOT NULL)";
        resultCode = [self createTableWithName:@"tasks" query:query database:database];
        if (resultCode == 1) {
            sqlite3_close(database);
            return;
        }
        query = @"CREATE TABLE colors (id integer PRIMARY KEY, red integer NOT NULL, green integer NOT NULL, blue integer NOT NULL, alpha NOT NULL)";
        resultCode = [self createTableWithName:@"colors" query:query database:database];
        if (resultCode == 1) {
            sqlite3_close(database);
            return;
        }
        query = @"CREATE TABLE icons (id integer PRIMARY KEY, path text NOT NULL)";
        resultCode = [self createTableWithName:@"icons" query:query database:database];
        if (resultCode == 1) {
            sqlite3_close(database);
            return;
        }
    } else {
        NSLog(@"Open table failed");
    }
    sqlite3_close(database);
    [self fillInitialData];
}

- (NSUInteger)createTableWithName:(NSString *)tableName query:(NSString *)query database:(sqlite3 *)database {;
    if (sqlite3_exec(database, [query UTF8String], NULL, NULL, NULL) == SQLITE_OK) {
        NSLog(@"%@ table created", tableName);
        return 0;
    } else {
        NSLog(@"%@ table did not created", tableName);
        return 1;
    }
}

#pragma mark - Filling initial data

- (void)fillInitialData {
    //initial Colors
    ColorService *colorService = [[ColorService alloc] init];
    NSUInteger colorId = 1;
    [colorService addColorWithRed:90 green:200 blue:250 alpha:255 colorId:colorId++];
    [colorService addColorWithRed:255 green:204 blue:0 alpha:255 colorId:colorId++];
    [colorService addColorWithRed:255 green:149 blue:0 alpha:255 colorId:colorId++];
    [colorService addColorWithRed:255 green:45 blue:85 alpha:255 colorId:colorId++];
    [colorService addColorWithRed:76 green:217 blue:100 alpha:255 colorId:colorId++];
    [colorService addColorWithRed:255 green:59 blue:48 alpha:255 colorId:colorId++];
    
    //initial Icons
    IconService *iconService = [[IconService alloc] init];
    for (int i = 1; i <= 12; i++) {
        NSString *path = [NSString stringWithFormat:@"icon%d", i];
        [iconService addIconWithPath:path andIconId:i];
    }
}

#pragma mark - Quering

- (void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable {
    sqlite3 *db = NULL;
    int resultCode = SQLITE_OK;
    NSString *databasePath = [self.documentsDirectory stringByAppendingPathComponent:kDatabaseFilename];
    
    [self setupArrays];
    
    resultCode = sqlite3_open([databasePath UTF8String], &db);
    if (resultCode != SQLITE_OK) {
        NSLog(@"Database opening error: %s", sqlite3_errmsg(db));
        sqlite3_close(db);
        return;
    }
    
    sqlite3_stmt *compiledStatement;
    resultCode = sqlite3_prepare_v2(db, query, -1, &compiledStatement, NULL);
    if (resultCode != SQLITE_OK) {
        NSLog(@"Error: %s", sqlite3_errmsg(db));
        sqlite3_finalize(compiledStatement);
        sqlite3_close(db);
        return;
    }
    
    if (queryExecutable) {
        [self runNonExecutableQuery:compiledStatement db:db];
    } else {
        [self runExecutableQuery:compiledStatement db:db];
    }
    
    sqlite3_finalize(compiledStatement);
    sqlite3_close(db);

}

- (void)runNonExecutableQuery:(sqlite3_stmt *)compiledStatement db:(sqlite3 *)db {
    int resultCode = sqlite3_step(compiledStatement);
    if (resultCode != SQLITE_DONE) {
        NSLog(@"DB Error: %s", sqlite3_errmsg(db));
        sqlite3_finalize(compiledStatement);
        sqlite3_close(db);
        return;
    }
}

- (void)runExecutableQuery:(sqlite3_stmt *)compiledStatement db:(sqlite3 *)db {
    NSMutableArray *arrDataRow;
    while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
        arrDataRow = [[NSMutableArray alloc] init];
        int totalColumnsCount = sqlite3_column_count(compiledStatement);
        for (int i = 0; i < totalColumnsCount; i++) {
            char *dbDataAsChars = (char *)sqlite3_column_text(compiledStatement, i);
            if (arrDataRow != NULL) {
                [arrDataRow addObject:[NSString  stringWithUTF8String:dbDataAsChars]];
            }
            if (self.arrColumnNames.count != totalColumnsCount) {
                dbDataAsChars = (char *)sqlite3_column_name(compiledStatement, i);
                [self.arrColumnNames addObject:[NSString stringWithUTF8String:dbDataAsChars]];
            }
        }
        if (arrDataRow.count > 0) {
            [self.arrResults addObject:arrDataRow];
        }
    }
}

- (NSArray *)loadDataFromDB:(NSString *)query{
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    return (NSArray *)self.arrResults;
}

- (void)executeQuery:(NSString *)query{
    [self runQuery:[query UTF8String] isQueryExecutable:YES];
}

+ (void)executeQuery:(NSString *)query {
    DatabaseManager *databaseManager = [[DatabaseManager alloc] init];
    [databaseManager executeQuery:query];
}

#pragma mark - Other

- (void)setupArrays {
    if (self.arrResults != nil) {
        [self.arrResults removeAllObjects];
        self.arrResults = nil;
    }
    self.arrResults = [[NSMutableArray alloc] init];
    
    if (self.arrColumnNames != nil) {
        [self.arrColumnNames removeAllObjects];
        self.arrColumnNames = nil;
    }
    self.arrColumnNames = [[NSMutableArray alloc] init];
}

- (NSUInteger)getLastIdForEntity:(NSString *)entity {
    NSUInteger maxId = 0;
    DatabaseManager *databaseManager = [[DatabaseManager alloc] init];
    NSString *query = [NSString stringWithFormat:@"SELECT id FROM %@ WHERE id = (SELECT MAX(id) FROM %@)", entity, entity];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithArray:[databaseManager loadDataFromDB:query]];
    NSUInteger indexOfId = [databaseManager.arrColumnNames indexOfObject:@"id"];
    if ([objects count] != 0) {
        maxId = [[objects firstObject][indexOfId] integerValue];
    }
    return maxId;
}

@end

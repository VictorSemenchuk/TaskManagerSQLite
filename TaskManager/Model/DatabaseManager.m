//
//  DatabaseManager.m
//  TaskManager
//
//  Created by Victor Macintosh on 08/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "DatabaseManager.h"
#import <sqlite3.h>

@interface DatabaseManager ()

@property (nonatomic) NSString *documentsDirectory;
@property (nonatomic) NSString *databaseFilename;
@property (nonatomic) NSMutableArray *arrResults;

- (void)copyDatabaseIntoDocumentsDirectory;
- (void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;

@end

@implementation DatabaseManager

- (id)initWithDatabaseFilename:(NSString *)dbFilename {
    self = [super init];
    if (self) {
        self.documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        self.databaseFilename = dbFilename;
        [self copyDatabaseIntoDocumentsDirectory];
    }
    return self;
}

- (void)copyDatabaseIntoDocumentsDirectory {
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFilename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        if (error != nil) {
            NSLog(@"Copying database to documents directory error: %@", [error localizedDescription]);
        }
    }
}

- (void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable {
    sqlite3 *db = NULL;
    int resultCode = SQLITE_OK;
    
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
    
    NSString *databasePath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    
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
        resultCode = sqlite3_step(compiledStatement);
        if (resultCode != SQLITE_OK) {
            NSLog(@"DB Error: %s", sqlite3_errmsg(db));
            sqlite3_finalize(compiledStatement);
            sqlite3_close(db);
            return;
        }
    } else {
        NSMutableArray *arrDataRow;
        while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
            arrDataRow = [[NSMutableArray alloc] init];
            int totalColumnsCount = sqlite3_column_count(compiledStatement);
            for (int i = 0; i < totalColumnsCount; i++) {
                char *dbDataAsChars = (char *)sqlite3_column_text(compiledStatement, i);
                if (arrDataRow != NULL) {
                    [arrDataRow addObject:[NSString  stringWithUTF8String:dbDataAsChars]];
                }
            }
            if (arrDataRow.count > 0) {
                [self.arrResults addObject:arrDataRow];
            }
        }
    }
    
    sqlite3_finalize(compiledStatement);
    sqlite3_close(db);
    
//    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);
//    if (openDatabaseResult == SQLITE_OK) {
//        sqlite3_stmt *compiledStatement;
//
//        BOOL prepareStatementResult = sqlite3_prepare_v2(sqlite3Database, query, -1, &compiledStatement, NULL);
//        if (prepareStatementResult == SQLITE_OK) {
//            if (!queryExecutable) {
//                NSMutableArray *arrDataRow;
//
//                while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
//                    arrDataRow = [[NSMutableArray alloc] init];
//                    int totalColumns = sqlite3_column_count(compiledStatement);
//
//                    for (int i = 0; i < totalColumns; i++) {
//                        char *dbDataAsChars = (char *)sqlite3_column_text(compiledStatement, i);
//
//                        if (dbDataAsChars != NULL) {
//                            [arrDataRow addObject:[NSString  stringWithUTF8String:dbDataAsChars]];
//                        }
//
//                        if (self.arrColumnNames.count != totalColumns) {
//                            dbDataAsChars = (char *)sqlite3_column_name(compiledStatement, i);
//                            [self.arrColumnNames addObject:[NSString stringWithUTF8String:dbDataAsChars]];
//                        }
//                    }
//
//                    if (arrDataRow.count > 0) {
//                        [self.arrResults addObject:arrDataRow];
//                    }
//                }
//            } else {
//                // This is the case of an executable query (insert, update, ...).
//
//                // Execute the query.
//                BOOL executeQueryResults = sqlite3_step(compiledStatement);
//                if (executeQueryResults == SQLITE_DONE) {
//                    // Keep the affected rows.
//                    self.affectedRows = sqlite3_changes(sqlite3Database);
//
//                    // Keep the last inserted row ID.
//                    self.lastInsertedRowID = sqlite3_last_insert_rowid(sqlite3Database);
//                }
//                else {
//                    // If could not execute the query show the error message on the debugger.
//                    NSLog(@"DB Error: %s", sqlite3_errmsg(sqlite3Database));
//                }
//            }
//        } else {
//            // In the database cannot be opened then show the error message on the debugger.
//            NSLog(@"%s", sqlite3_errmsg(sqlite3Database));
//        }
//        sqlite3_finalize(compiledStatement);
//    }
//    sqlite3_close(sqlite3Database);
    
    
}

- (NSArray *)loadDataFromDB:(NSString *)query{
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    return (NSArray *)self.arrResults;
}

- (void)executeQuery:(NSString *)query{
    [self runQuery:[query UTF8String] isQueryExecutable:YES];
}

@end

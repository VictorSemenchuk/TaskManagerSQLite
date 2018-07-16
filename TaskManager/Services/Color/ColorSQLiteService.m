//
//  ColorService.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ColorSQLiteService.h"

@interface ColorSQLiteService ()

- (NSMutableArray *)loadDataWithQuery:(NSString *)query;

@end

@implementation ColorSQLiteService

- (NSMutableArray *)loadAllColors {
    NSString *query = @"SELECT * FROM colors";
    NSMutableArray *colors = [self loadDataWithQuery:query];
    return colors;
}

- (Color *)loadColorWithId:(NSUInteger)colorId {
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM colors WHERE id = %lu", colorId];
    Color* color = [self loadDataWithQuery:query][0];
    return color;
}

- (void)addColorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha {
    NSString *query = [NSString stringWithFormat:@"INSERT INTO colors (red, green, blue, alpha) VALUES (%lu, %lu, %lu, %lu)", red, green, blue, alpha];
    [DatabaseManager executeQuery:query];
}

- (NSMutableArray *)loadDataWithQuery:(NSString *)query {
    DatabaseManager *databaseManager = [[DatabaseManager alloc] initWithDatabaseFilename:kDatabaseFilename];
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    NSMutableArray *objects = [[NSMutableArray alloc] initWithArray:[databaseManager loadDataFromDB:query]];
    
    NSInteger indexOfId = [databaseManager.arrColumnNames indexOfObject:@"id"];
    NSInteger indexOfRed = [databaseManager.arrColumnNames indexOfObject:@"red"];
    NSInteger indexOfGreen = [databaseManager.arrColumnNames indexOfObject:@"green"];
    NSInteger indexOfBlue = [databaseManager.arrColumnNames indexOfObject:@"blue"];
    NSInteger indexOfAlpha = [databaseManager.arrColumnNames indexOfObject:@"alpha"];
    
    for(int i = 0; i < [objects count]; i++) {
        Color *color = [[Color alloc] initWithId:[objects[i][indexOfId] integerValue]
                                             red:[objects[i][indexOfRed] integerValue]
                                           green:[objects[i][indexOfGreen] integerValue]
                                            blue:[objects[i][indexOfBlue] integerValue]
                                           alpha:[objects[i][indexOfAlpha] integerValue]];
        [colors addObject:color];
    }
    
    return colors;
}

@end

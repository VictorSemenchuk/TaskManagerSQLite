//
//  Color.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "Color.h"
#import "DatabaseManager.h"

@interface Color ()

+ (NSMutableArray *)loadDataWithQuery:(NSString *)query;

@end

@implementation Color

- (id)initWithId:(NSUInteger)colorId red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha {
    self = [super init];
    if (self) {
        _colorId = colorId;
        _red = red;
        _green = green;
        _blue = blue;
        _alpha = alpha;
        
        _color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];
    }
    return self;
}

+ (NSMutableArray *)loadAllColors {
    NSString *query = @"SELECT * FROM colors";
    NSMutableArray *colors = [Color loadDataWithQuery:query];
    return colors;
}

+ (Color *)loadColorWithId:(NSUInteger)colorId {
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM colors WHERE id = %lu", colorId];
    Color* color = [Color loadDataWithQuery:query][0];
    return color;
}

+ (void)addColorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha {
    NSString *query = [NSString stringWithFormat:@"INSERT INTO colors (red, green, blue, alpha) VALUES (%lu, %lu, %lu, %lu)", red, green, blue, alpha];
    [DatabaseManager executeQuery:query];
}

+ (NSMutableArray *)loadDataWithQuery:(NSString *)query {
    
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

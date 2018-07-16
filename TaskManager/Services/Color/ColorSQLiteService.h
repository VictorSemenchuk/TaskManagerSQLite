//
//  ColorService.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseManager.h"
#import "Color.h"

@interface ColorSQLiteService : NSObject

- (NSMutableArray *)loadAllColors;
- (Color *)loadColorWithId:(NSUInteger)colorId;
- (void)addColorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha;

@end

//
//  IconService.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseManager.h"
#import "Icon.h"

@interface IconSQLiteService : NSObject

- (NSMutableArray *)loadAllIcons;
- (Icon *)loadIconWithId:(NSUInteger)iconId;
- (void)addIconWithPath:(NSString *)path;

@end

//
//  DatabaseManager.h
//  TaskManager
//
//  Created by Victor Macintosh on 08/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersistentManagerProtocol.h"

@interface DatabaseManager : NSObject <PersistentManagerProtocol>

@property (nonatomic) NSMutableArray *arrColumnNames;

- (NSArray *)loadDataFromDB:(NSString *)query;
- (void)executeQuery:(NSString *)query;
+ (void)executeQuery:(NSString *)query;

@end

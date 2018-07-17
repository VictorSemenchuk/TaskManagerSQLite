//
//  IconService.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/17/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IconSQLiteService.h"
#import "IconCoreDataService.h"
#import "PersistentType.h"
#import "IconServiceProtocol.h"

@interface IconService : NSObject <IconServiceProtocol>

@property (nonatomic) IconCoreDataService *iconCoreDataService;
@property (nonatomic) IconSQLiteService *iconSQLiteService;
@property (assign, nonatomic) PersistentType persistentType;

@end

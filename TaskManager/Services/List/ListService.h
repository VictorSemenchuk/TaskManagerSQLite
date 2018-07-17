//
//  ListService.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/17/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListServiceProtocol.h"
#import "ListSQLiteService.h"
#import "ListCoreDataService.h"
#import "PersistentType.h"

@interface ListService : NSObject <ListServiceProtocol>

@property (nonatomic) ListCoreDataService *listCoreDataService;
@property (nonatomic) ListSQLiteService *listSQLiteService;
@property (assign, nonatomic) PersistentType persistentType;

@end

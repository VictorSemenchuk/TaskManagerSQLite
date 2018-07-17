//
//  TaskService.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/17/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskServiceProtocol.h"
#import "TaskSQLiteService.h"
#import "TaskCoreDataService.h"
#import "PersistentType.h"

@interface TaskService : NSObject <TaskServiceProtocol>

@property (nonatomic) TaskCoreDataService *taskCoreDataService;
@property (nonatomic) TaskSQLiteService *taskSQLiteService;
@property (assign, nonatomic) PersistentType persistentType;

@end

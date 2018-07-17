//
//  TaskService.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseManager.h"
#import "Task.h"
#import "TaskServiceProtocol.h"

@interface TaskSQLiteService : NSObject <TaskServiceProtocol>

@end

//
//  ListService.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseManager.h"
#import "List.h"
#import "ListServiceProtocol.h"

@interface ListSQLiteService : NSObject <ListServiceProtocol>

@end

//
//  TaskCoreData.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/20/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ListCoreData.h"

@interface TaskCoreData : NSManagedObject

@property (assign, nonatomic) NSUInteger taskId;
@property (assign, nonatomic) NSUInteger listId;
@property (assign, nonatomic) NSString *text;
@property (assign, nonatomic) BOOL isChecked;
@property (assign, nonatomic) NSUInteger priority;

@property (nonatomic) ListCoreData *list;

@end

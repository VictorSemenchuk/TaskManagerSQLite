//
//  Task.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskCoreData.h"

@interface Task : NSObject

@property (assign, nonatomic) NSUInteger taskId;
@property (assign, nonatomic) NSUInteger listId;
@property (nonatomic) NSString *text;
@property (assign, nonatomic) BOOL isChecked;
@property (assign, nonatomic) NSUInteger priority;

- (instancetype)initWithId:(NSUInteger)taskId listId:(NSUInteger)listId text:(NSString *)text isChecked:(BOOL)isChecked priority:(NSUInteger)priority;
- (instancetype)initWithMO:(TaskCoreData *)taskMO;

@end

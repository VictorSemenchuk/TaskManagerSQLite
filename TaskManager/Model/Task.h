//
//  Task.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (assign, nonatomic) NSUInteger taskId;
@property (assign, nonatomic) NSUInteger listId;
@property (nonatomic) NSString *text;
@property (assign, nonatomic) BOOL isChecked;

- (id)initWithId:(NSUInteger)taskId listId:(NSUInteger)listId text:(NSString *)text isChecked:(BOOL)isChecked;
+ (NSMutableArray *)loadTasksForListWithId:(NSUInteger)listId;
+ (void)addNewTaskWithText:(NSString *)text andListId:(NSUInteger)listId;
+ (void)updateCheckForTaskWithId:(NSUInteger)taskId oldValue:(BOOL)isChecked;
+ (void)removeTaskWithId:(NSUInteger)taskId;
+ (void)updateTaskWithId:(NSUInteger)taskId text:(NSString *)text;

@end

//
//  ListServiceProtocol.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/17/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "List.h"

@protocol ListServiceProtocol <NSObject>

- (NSUInteger)addNewListWithTitle:(NSString *)title iconId:(NSUInteger)iconId colorId:(NSUInteger)colorId;
- (NSMutableArray *)loadAllLists;
- (List *)loadListWithId:(NSUInteger)listId;
- (void)removeListWithId:(NSUInteger)listId;
- (NSInteger)getCountUncheckedTasksForListId:(NSUInteger)listId;

@end

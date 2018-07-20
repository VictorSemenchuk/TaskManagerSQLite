//
//  CoreDataManager.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PersistentManagerProtocol.h"

@interface CoreDataManager : NSObject <PersistentManagerProtocol>

- (void)fillInitialData;
- (NSArray *)fetchEntitiesWithName:(NSString *)entityName byPredicate:(NSPredicate *)predicate;
- (NSUInteger)addNewInstanceForEntityWithName:(NSString *)entityName withAssigningBlock:(void (^)(NSManagedObject *currentEntity, NSUInteger currentEntityId, NSManagedObjectContext *context))assigningBlock;
- (int)removeEntityWithName:(NSString *)entityName byPredicate:(NSPredicate *)predicate;
- (void)updateEntityWithName:(NSString *)entityName byPredicate:(NSPredicate *)predicate withUpdatingBlock:(void(^)(NSManagedObject *object))updatingBlock;

@end

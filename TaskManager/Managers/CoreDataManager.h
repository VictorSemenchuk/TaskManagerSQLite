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

@property (nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)fillInitialData;

@end

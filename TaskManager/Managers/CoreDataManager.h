//
//  CoreDataManager.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

@property (nonatomic) NSManagedObjectContext *managedObjectContext;

- (instancetype)initWithModelName:(NSString *)modelName;

@end

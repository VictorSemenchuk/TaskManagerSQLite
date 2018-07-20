//
//  IconCoreData.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/20/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface IconCoreData : NSManagedObject

@property (assign, nonatomic) NSUInteger iconId;
@property (nonatomic) NSString *path;

@end

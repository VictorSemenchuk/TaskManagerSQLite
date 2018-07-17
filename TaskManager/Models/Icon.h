//
//  Icon.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Icon : NSManagedObject

@property (assign, nonatomic) NSUInteger iconId;
@property (nonatomic) NSString *path;

- (id)initWithId:(NSUInteger)iconId andPath:(NSString *)path;

@end

//
//  ColorCoreData.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/20/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ColorCoreData : NSManagedObject

@property (assign, nonatomic) NSUInteger colorId;
@property (assign, nonatomic) NSUInteger red;
@property (assign, nonatomic) NSUInteger green;
@property (assign, nonatomic) NSUInteger blue;
@property (assign, nonatomic) NSUInteger alpha;

@end

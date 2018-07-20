//
//  ListCoreData.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/20/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ColorCoreData.h"
#import "IconCoreData.h"

@interface ListCoreData : NSManagedObject

@property (assign, nonatomic) NSUInteger listId;
@property (nonatomic) NSString *title;
@property (assign, nonatomic) NSUInteger iconId;
@property (assign, nonatomic) NSUInteger colorId;

@property (nonatomic) IconCoreData *icon;
@property (nonatomic) ColorCoreData *color;
@property (nonatomic) NSSet *tasks;

@end

//
//  List.h
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Icon.h"
#import "Color.h"
#import "TaskCoreData.h"

@interface List : NSObject

@property (assign, nonatomic) NSUInteger listId;
@property (nonatomic) NSString *title;
@property (assign, nonatomic) NSUInteger iconId;
@property (assign, nonatomic) NSUInteger colorId;

@property (assign, nonatomic) NSInteger uncheckedTasksCount;

@property (nonatomic) Icon *icon;
@property (nonatomic) Color *color;

- (instancetype)initWithId:(NSUInteger)listId title:(NSString *)title iconId:(NSUInteger)iconId colorId:(NSUInteger)colorId;
- (instancetype)initWithMO:(ListCoreData *)listMO;

@end

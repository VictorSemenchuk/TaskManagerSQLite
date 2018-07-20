//
//  Color.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ColorCoreData.h"

@interface Color : NSObject

@property (assign, nonatomic) NSUInteger colorId;
@property (assign, nonatomic) NSUInteger red;
@property (assign, nonatomic) NSUInteger green;
@property (assign, nonatomic) NSUInteger blue;
@property (assign, nonatomic) NSUInteger alpha;

@property (nonatomic) UIColor *color;

- (instancetype)initWithId:(NSUInteger)colorId red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha;
- (instancetype)initWithMO:(ColorCoreData *)color;

@end

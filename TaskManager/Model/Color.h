//
//  Color.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Color : NSObject

@property (nonatomic) NSUInteger colorId;
@property (nonatomic) NSUInteger red;
@property (nonatomic) NSUInteger green;
@property (nonatomic) NSUInteger blue;
@property (nonatomic) NSUInteger alpha;

@property (nonatomic) UIColor *color;

- (id)initWithId:(NSUInteger)colorId red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha;
+ (NSMutableArray *)loadAllColors;
+ (Color *)loadColorWithId:(NSUInteger)colorId;

@end

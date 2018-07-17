//
//  ColorServiceProtocol.h
//  TaskManager
//
//  Created by Victor Macintosh on 16/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Color.h"

@protocol ColorServiceProtocol <NSObject>

- (NSMutableArray *)loadAllColors;
- (Color *)loadColorWithId:(NSUInteger)colorId;
- (void)addColorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha colorId:(NSUInteger)colorId;

@end

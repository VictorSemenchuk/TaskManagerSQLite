//
//  Color.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "Color.h"

@implementation Color

- (instancetype)initWithId:(NSUInteger)colorId red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha {
    self = [super init];
    if (self) {
        _colorId = colorId;
        _red = red;
        _green = green;
        _blue = blue;
        _alpha = alpha;
        
        _color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];
    }
    return self;
}

- (instancetype)initWithMO:(ColorCoreData *)color {
    self = [super init];
    if (self) {
        _colorId = color.colorId;
        _red = color.red;
        _green = color.green;
        _blue = color.blue;
        _alpha = color.alpha;
        
        _color = [UIColor colorWithRed:_red/255.0 green:_green/255.0 blue:_blue/255.0 alpha:_alpha/255.0];
    }
    return self;
}

@end

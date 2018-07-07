//
//  List.m
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "List.h"

@implementation List

- (id)initWithTitle:(NSString *)title iconTitle:(NSString *)iconTitle andColor:(UIColor *)color {
    self = [super init];
    if (self) {
        _title = title;
        _iconTitle = iconTitle;
        _color = color;
    }
    return self;
}

@end

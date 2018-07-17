//
//  Icon.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "Icon.h"

@implementation Icon

@synthesize iconId = _iconId;
@synthesize path = _path;

- (id)initWithId:(NSUInteger)iconId andPath:(NSString *)path {
    self = [super init];
    if (self) {
        _iconId = iconId;
        _path = path;
    }
    return self;
}

@end

//
//  Icon.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/9/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "Icon.h"

@implementation Icon

- (instancetype)initWithId:(NSUInteger)iconId andPath:(NSString *)path {
    self = [super init];
    if (self) {
        _iconId = iconId;
        _path = path;
    }
    return self;
}

- (instancetype)initWithMO:(IconCoreData *)iconMO {
    self = [super init];
    if (self) {
        _iconId = iconMO.iconId;
        _path = iconMO.path;
    }
    return self;
}

@end

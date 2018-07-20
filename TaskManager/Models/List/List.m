//
//  List.m
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "List.h"

@implementation List

- (instancetype)initWithId:(NSUInteger)listId title:(NSString *)title iconId:(NSUInteger)iconId colorId:(NSUInteger)colorId {
    self = [super init];
    if (self) {
        _listId = listId;
        _title = title;
        _iconId = iconId;
        _colorId = colorId;
        
        _uncheckedTasksCount = 0;
    }
    return self;
}

- (instancetype)initWithMO:(ListCoreData *)listMO {
    self = [super init];
    if (self) {
        _listId = listMO.listId;
        _title = listMO.title;
        _iconId = listMO.iconId;
        _colorId = listMO.colorId;
    }
    return self;
}

@end

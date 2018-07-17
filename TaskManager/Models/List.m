//
//  List.m
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "List.h"

@implementation List

@synthesize listId = _listId;
@synthesize title = _title;
@synthesize iconId = _iconId;
@synthesize colorId = _colorId;
@synthesize uncheckedTasksCount = _uncheckedTasksCount;
@synthesize color = _color;
@synthesize icon = _icon;

- (id)initWithId:(NSUInteger)listId title:(NSString *)title iconId:(NSUInteger)iconId colorId:(NSUInteger)colorId {
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

@end

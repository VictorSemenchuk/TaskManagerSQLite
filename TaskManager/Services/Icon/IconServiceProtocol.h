//
//  IconServiceProtocol.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/17/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Icon.h"

@protocol IconServiceProtocol <NSObject>

- (NSMutableArray *)loadAllIcons;
- (Icon *)loadIconWithId:(NSUInteger)iconId;
- (void)addIconWithPath:(NSString *)path andIconId:(NSUInteger)iconId;

@end

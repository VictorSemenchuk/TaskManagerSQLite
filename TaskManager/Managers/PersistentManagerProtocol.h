//
//  PersistentManagerProtocol.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/17/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

@protocol PersistentManagerProtocol

- (NSUInteger)getLastIdForEntity:(NSString *)entity;

@end

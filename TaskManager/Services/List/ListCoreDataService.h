//
//  ListCoreDataService.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListServiceProtocol.h"
#import "ListCoreData.h"

@interface ListCoreDataService : NSObject <ListServiceProtocol>

- (ListCoreData *)fetchListWithId:(NSUInteger)listId inContext:(NSManagedObjectContext *)context;

@end

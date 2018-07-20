//
//  ColorCoreDataService.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Color.h"
#import "ColorServiceProtocol.h"

@interface ColorCoreDataService : NSObject <ColorServiceProtocol>

- (ColorCoreData *)fetchColorWithId:(NSUInteger)colorId inContext:(NSManagedObjectContext *)context;

@end

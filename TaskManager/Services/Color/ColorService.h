//
//  ColorService.h
//  TaskManager
//
//  Created by Victor Macintosh on 16/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColorSQLiteService.h"
#import "ColorCoreDataService.h"
#import "PersistentType.h"
#import "ColorServiceProtocol.h"

@interface ColorService : NSObject <ColorServiceProtocol>

@property (nonatomic) ColorCoreDataService *colorCoreDataService;
@property (nonatomic) ColorSQLiteService *colorSQLiteService;
@property (assign, nonatomic) PersistentType persistentType;

@end

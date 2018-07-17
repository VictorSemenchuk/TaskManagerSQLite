//
//  ColorService.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseManager.h"
#import "Color.h"
#import "ColorServiceProtocol.h"

@interface ColorSQLiteService : NSObject <ColorServiceProtocol>

@end

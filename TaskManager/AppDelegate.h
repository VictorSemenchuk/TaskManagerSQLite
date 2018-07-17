//
//  AppDelegate.h
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersistentType.h"
#import "CoreDataManager.h"
#import "DatabaseManager.h"

static PersistentType selectedPersistentType = kCoreData;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) CoreDataManager *coreDataManager;
@property (nonatomic) DatabaseManager *databaseManager;


@end


//
//  AppDelegate.m
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "AppDelegate.h"
#import "ListsTableViewController.h"
#import "CoreDataManager.h"
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kPersistantTypeUserDefaultsKey]) {
        [[NSUserDefaults standardUserDefaults] setInteger:kSQLite forKey:kPersistantTypeUserDefaultsKey];
    }
    
    CGRect frame = UIScreen.mainScreen.bounds;
    UIWindow *window = [[UIWindow alloc] initWithFrame:frame];
    
    ListsTableViewController *rootVC = [[ListsTableViewController alloc] init];
    UINavigationController *rootNavigationVC = [[UINavigationController alloc] initWithRootViewController:rootVC];
    window.rootViewController = rootNavigationVC;
    
    self.coreDataManager = [[CoreDataManager alloc] init];
    self.databaseManager = [[DatabaseManager alloc] init];
    
    self.window = window;
    [window makeKeyAndVisible];
    
    return YES;
}

@end

//
//  CoreDataManager.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/16/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "CoreDataManager.h"
#import "IconCoreDataService.h"
#import "ColorCoreDataService.h"
#import "Constants.h"

static NSString * const kDatabaseFilename = @"TaskManagerCoreData.sqlite";
static NSString * const kModelName = @"TaskManager";

@interface CoreDataManager ()

@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSPersistentStoreCoordinator *persistentCoordinator;
@property (nonatomic) NSManagedObjectModel *managedObjectModel;

@end

@implementation CoreDataManager

#pragma mark - CoreData Stack Items

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        NSPersistentStoreCoordinator *persistentCoordinator = self.persistentCoordinator;
        if (persistentCoordinator != nil) {
            _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
            _managedObjectContext.persistentStoreCoordinator = persistentCoordinator;
        }
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        NSURL *modelURL = [NSBundle.mainBundle URLForResource:kModelName withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentCoordinator {
    if (!_persistentCoordinator) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSURL *storeURL = [documentsURL URLByAppendingPathComponent:kDatabaseFilename];
        NSLog(@"CoreData persistent store URL: %@", storeURL);
        
        NSError *error;
        _persistentCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        if (![_persistentCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    return _persistentCoordinator;
}

#pragma mark - Filling persistent store by default values

- (void)fillInitialData {
    //initial Colors
    ColorCoreDataService *colorCoreDataService = [[ColorCoreDataService alloc] init];
    NSUInteger colorId = 1;
    [colorCoreDataService addColorWithRed:90 green:200 blue:250 alpha:255 colorId:colorId++];
    [colorCoreDataService addColorWithRed:255 green:204 blue:0 alpha:255 colorId:colorId++];
    [colorCoreDataService addColorWithRed:255 green:149 blue:0 alpha:255 colorId:colorId++];
    [colorCoreDataService addColorWithRed:255 green:45 blue:85 alpha:255 colorId:colorId++];
    [colorCoreDataService addColorWithRed:76 green:217 blue:100 alpha:255 colorId:colorId++];
    [colorCoreDataService addColorWithRed:255 green:59 blue:48 alpha:255 colorId:colorId++];
    
    //initial Icons
    IconCoreDataService *iconCoreDataService = [[IconCoreDataService alloc] init];
    for (int i = 1; i <= 12; i++) {
        NSString *path = [NSString stringWithFormat:@"icon%d", i];
        [iconCoreDataService addIconWithPath:path andIconId:i];
    }
}

#pragma mark - PersistentManagerProtocol

- (NSUInteger)getLastIdForEntity:(NSString *)entity {
    NSUInteger maxId = 0;
    
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSManagedObjectContext *context = coreDataManager.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[NSString stringWithFormat:@"%@", entity]];
    NSString *attribute = [NSString stringWithFormat:@"%@Id%@", [entity lowercaseString], kAttributesPostfix];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == max(%K)", attribute, attribute];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] != 0) {
        maxId = [[objects.firstObject valueForKey:[@"listId" stringByAppendingString:kAttributesPostfix]] integerValue];
    }
    
    return maxId;
}

#pragma mark - Operations

- (NSArray *)fetchEntitiesWithName:(NSString *)entityName byPredicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    if (predicate) {
        [request setPredicate:predicate];
    }
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!error) {
        return results;
    } else {
        return nil;
    }
}

- (NSUInteger)addNewInstanceForEntityWithName:(NSString *)entityName withAssigningBlock:(void (^)(NSManagedObject *currentEntity, NSUInteger currentEntityId))assigningBlock {
    NSUInteger currentEntityId = [self getLastIdForEntity:entityName] + 1;
    NSManagedObject *currentEntity = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
    assigningBlock(currentEntity, currentEntityId);
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    return currentEntityId;
}

- (int)removeEntityWithName:(NSString *)entityName byPredicate:(NSPredicate *)predicate {
    NSArray *results = [self fetchEntitiesWithName:entityName byPredicate:predicate];
    if (results) {
        for(NSManagedObject *managedObject in results) {
            [self.managedObjectContext deleteObject:managedObject];
        }
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
            return 1;
        }
    }
    return 0;
}

- (void)updateEntityWithName:(NSString *)entityName byPredicate:(NSPredicate *)predicate withUpdatingBlock:(void (^)(NSManagedObject *))updatingBlock {
    NSArray *results = [self fetchEntitiesWithName:entityName byPredicate:predicate];
    if (results) {
        NSManagedObject *object = results.firstObject;
        updatingBlock(object);
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
}


@end

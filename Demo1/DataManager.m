//
//  DataManager.m
//  Demo1
//
//  Created by Mohammad Bharmal on 3/25/15.
//  Copyright (c) 2015 Parth Dobariya. All rights reserved.
//

#import "DataManager.h"
#import "AppDelegate.h"
#import "Model.h"


#define entity_person @"Person"

@import CoreData;
static DataManager *dataManager;
@interface DataManager()
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation DataManager
+(DataManager*)getManager{
    if (!dataManager) {
        dataManager = [[DataManager alloc] init];
        [dataManager managedObjectContext];
    }
    return dataManager;
}

- (void)saveContext{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSManagedObjectContext *)getManagedObjectContext{
    if (self.managedObjectContext != nil) {
        return self.managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self getPersistentStoreCoordinator];
    if (coordinator != nil) {
        self.managedObjectContext = [[NSManagedObjectContext alloc] init];
        [self.managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return self.managedObjectContext;
}

- (NSManagedObjectModel *)getManagedObjectModel{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DataModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)getPersistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[AppDelegate applicationDocumentsDirectory] URLByAppendingPathComponent:@"DataModel.momd"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self getManagedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
#ifdef DEBUB
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
#endif
    }
    
    return _persistentStoreCoordinator;
}

-(BOOL)saveUser:(Model*)model{
    NSManagedObjectContext *context = [self getManagedObjectContext];
    // Create a new managed object
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:entity_person inManagedObjectContext:context];
    [newDevice setValue:model.firstName forKey:first_name];
    [newDevice setValue:model.lastName forKey:last_name];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        
#ifdef DEBUB
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
#endif
        return false;
    }
    else{
        return true;
    }

}
-(void)deleteUser:(Model*)m{
    [[self getManagedObjectContext] deleteObject:[m getObj]];
}
-(NSArray*)fetchUserData{
    NSMutableArray *returnData = [[NSMutableArray alloc] init];
    NSMutableArray *arrPerson = [[NSMutableArray alloc] init];
    NSManagedObjectContext *managedObjectContext = [self getManagedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entity_person];
    arrPerson = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    for(int i=0; i<[arrPerson count]; i++){
        NSManagedObject *obj = [arrPerson objectAtIndex:i];
        Model *m = [[Model alloc] initWithManagedObject:obj];
        [returnData addObject:m];
    }
    return returnData;

}
@end

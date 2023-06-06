//
//  DatabaseProvider.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/5/23.
//

#import "DatabaseProvider.h"

@implementation DatabaseProvider

@synthesize persistentContainer = _persistentContainer;


- (NSPersistentContainer*) persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"GenshinHeroes"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                self->_persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    return _persistentContainer;
}


#pragma mark - Core Data Saving support


- (void) saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

// TODO: Remove later

- (NSArray*) getAllObjects {
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName: @"GenshinObject" inManagedObjectContext: self.persistentContainer.viewContext];
    [request setEntity: description];
    NSError* requestError = nil;
    NSPersistentStoreResult* result = [self.persistentContainer.viewContext executeRequest: request error: &requestError];
    if (requestError) {
        NSLog(@"%@", requestError.localizedDescription);
    }
    NSArray* objects = [result valueForKey: @"finalResult"];
    return objects;
}


- (void) deleteAllObjects {
    NSArray* objects = [self getAllObjects];
    for (id object in objects) {
        [self.persistentContainer.viewContext deleteObject: object];
    }
    [self.persistentContainer.viewContext save: nil];
}


@end

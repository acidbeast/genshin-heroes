//
//  CoreDataService.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/21/23.
//

#import "CoreDataService.h"

@implementation CoreDataService


+ (instancetype) shared {
    static CoreDataService* service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[CoreDataService alloc] init];
    });
    return service;
}


- (void) saveCharactersWith: (NSDictionary*) characters
                  onSuccess: (void(^)(void)) onSuccess
                    onError: (void(^)(NSError* error)) onError {
    // TODO: Remove!
//    [self deleteAllObjects];
    NSError* saveError = nil;
    for (id object in characters) {
        [self createCharacterFrom: object];
        
    }
    [self.persistentContainer.viewContext save: &saveError];
    if (saveError != nil) {
        onError(saveError);
    } else {
        onSuccess();
    }
}


- (Character*) createCharacterFrom: (NSDictionary*) characterData {
    Character* character = [NSEntityDescription insertNewObjectForEntityForName: @"Character" inManagedObjectContext: self.persistentContainer.viewContext];
    character.name = [characterData valueForKey: @"name"];
    character.title = [characterData valueForKey: @"title"];
    character.affiliation = [characterData valueForKey: @"affiliation"];
    character.rarity = [[characterData valueForKey: @"rarity"] integerValue];
    character.constellation = [characterData valueForKey: @"constellation"];
    character.birthday = [characterData valueForKey: @"birthday"];
    character.about = [characterData valueForKey: @"description"];
    character.gender = [characterData valueForKey: @"gender"];
    character.specialDish = [characterData valueForKey: @"specialDish"];
    character.nation = [self createNationFromCharacterData: characterData];
    character.vision = [self createVisionFromCharacterData: characterData];
    character.weapon = [self createWeaponFromCharacterData: characterData];
    return character;
}


- (Nation*) createNationFromCharacterData: (NSDictionary*) characterData {
    Nation* nation = [NSEntityDescription insertNewObjectForEntityForName: @"Nation" inManagedObjectContext: self.persistentContainer.viewContext];
    nation.name = [characterData valueForKey: @"nation"];
    return nation;
}


- (Vision*) createVisionFromCharacterData: (NSDictionary*) characterData {
    Vision* vision = [NSEntityDescription insertNewObjectForEntityForName: @"Vision" inManagedObjectContext: self.persistentContainer.viewContext];
    vision.name = [characterData valueForKey: @"vision"];
    vision.key = [characterData valueForKey: @"vision_key"];
    return vision;
}


- (Weapon*) createWeaponFromCharacterData: (NSDictionary*) characterData {
    Weapon* weapon = [NSEntityDescription insertNewObjectForEntityForName: @"Weapon" inManagedObjectContext: self.persistentContainer.viewContext];
    weapon.name = [characterData valueForKey: @"weapon"];
    weapon.type = [characterData valueForKey: @"weapon_type"];
    return weapon;
}


- (NSArray*) getCharacters {
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName: @"Character" inManagedObjectContext: self.persistentContainer.viewContext];
    [request setEntity: description];
    NSError* requestError = nil;
    NSPersistentStoreResult* result = [self.persistentContainer.viewContext executeRequest: request error: &requestError];
    if (requestError) {
        NSLog(@"%@", requestError.localizedDescription);
    }
    NSArray* characters = [result valueForKey: @"finalResult"];
    return characters;
}


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

#pragma mark - Core Data stack


@synthesize persistentContainer = _persistentContainer;


- (NSPersistentContainer *)persistentContainer {
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


@end

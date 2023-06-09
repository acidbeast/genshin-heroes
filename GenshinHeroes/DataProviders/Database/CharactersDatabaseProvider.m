//
//  CoreDataService.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/21/23.
//

#import "CharactersDatabaseProvider.h"

@interface CharactersDatabaseProvider ()

@property (strong, nonatomic) NSPersistentContainer* persistentContainer;

@end

@implementation CharactersDatabaseProvider

- (instancetype) initWithPersistentContainer: (NSPersistentContainer*) persistentContainer {
    self = [super init];
    if (self) {
        self.persistentContainer = persistentContainer;
    }
    return self;
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
    character.favorite = [self createFavorite];
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


- (Favorite*) createFavorite {
    Favorite* favorite = [NSEntityDescription insertNewObjectForEntityForName: @"Favorite" inManagedObjectContext: self.persistentContainer.viewContext];
    favorite.isFavorite = NO;
    return favorite;
}

#pragma mark - Characters

- (void) getCharactersWithPredicate: (NSPredicate*) predicate
                          onSuccess: (BlockWithCharactersList) successCallback
                            onError: (BlockWithError) errorCallback {
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName: @"Character" inManagedObjectContext: self.persistentContainer.viewContext];
    [request setEntity: description];
    if (predicate != nil) {
        [request setPredicate: predicate];
    }
    NSError* requestError = nil;
    NSPersistentStoreResult* result = [self.persistentContainer.viewContext executeRequest: request error: &requestError];
    if (requestError && errorCallback != nil) {
        errorCallback(requestError);
        return;
    }
    if (successCallback != nil) {
        NSArray* characters = [result valueForKey: @"finalResult"];
        successCallback(characters);
    }
}

- (void) getCharactersWithSuccess: (BlockWithCharactersList) successCallback
                          onError: (BlockWithError) errorCallback {
    [self getCharactersWithPredicate: nil
                           onSuccess: successCallback
                             onError: errorCallback];
}

- (void) getCharacterWithName: (NSString*) name
                    onSuccess: (BlockWithCharacter) successCallback
                      onError: (BlockWithError) errorCallback {
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"name = %@", name];
    // TODO: set limit to 1;
    [self getCharactersWithPredicate: predicate onSuccess:^(NSArray *characters) {
        if (successCallback != nil) {
            successCallback(characters[0]);
        }
    } onError: errorCallback];
}

- (void) saveCharactersWith: (NSDictionary*) characters
                  onSuccess: (void(^)(void)) onSuccess
                    onError: (void(^)(NSError* error)) onError {
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

@end

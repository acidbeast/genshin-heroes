//
//  CoreDataService.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/21/23.
//

#import "CharactersDatabaseProvider.h"

@implementation CharactersDatabaseProvider


+ (instancetype) shared {
    static CharactersDatabaseProvider* service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[CharactersDatabaseProvider alloc] init];
    });
    return service;
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

- (NSArray*) getCharactersWithPredicate: (NSPredicate*) predicate {
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName: @"Character" inManagedObjectContext: self.persistentContainer.viewContext];
    [request setEntity: description];
    if (predicate != nil) {
        [request setPredicate: predicate];
    }
    NSError* requestError = nil;
    NSPersistentStoreResult* result = [self.persistentContainer.viewContext executeRequest: request error: &requestError];
    if (requestError) {
        NSLog(@"%@", requestError.localizedDescription);
    }
    NSArray* characters = [result valueForKey: @"finalResult"];
    return characters;
}

- (NSArray*) getCharacters {
    return [self getCharactersWithPredicate: nil];
}

- (Character*) getCharacterWithName: (NSString*) name {
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"name = %@", name];
    return [self getCharactersWithPredicate: predicate][0];
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

@end

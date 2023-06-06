//
//  FavoritesDatabaseProvider.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/5/23.
//

#import "FavoritesDatabaseProvider.h"

@implementation FavoritesDatabaseProvider

+ (instancetype) shared {
    static FavoritesDatabaseProvider* service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[FavoritesDatabaseProvider alloc] init];
    });
    return service;
}


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

- (NSArray*) fetchFavorites {
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"favorite.isFavorite = YES"];
    return [self getCharactersWithPredicate: predicate];
}

- (void) saveCharacter: (Character*) character
     withFavoriteValue: (BOOL) favoriteValue
             onSuccess: (EmptyBlock) onSuccess
               onError: (BlockWitError) onError {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        character.favorite.isFavorite = favoriteValue;
        NSError* error = nil;
        [self.persistentContainer.viewContext save: &error];
        if (error != nil) {
            onError(error);
        } else {
            onSuccess();
        }
    });
}

@end

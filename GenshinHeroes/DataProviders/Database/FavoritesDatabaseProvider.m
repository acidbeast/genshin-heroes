//
//  FavoritesDatabaseProvider.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/5/23.
//

#import "FavoritesDatabaseProvider.h"

@interface FavoritesDatabaseProvider ()

@property (strong, nonatomic) NSPersistentContainer* persistentContainer;

@end

@implementation FavoritesDatabaseProvider

- (instancetype) initWithPersistentContainer: (NSPersistentContainer*) persistentContainer {
    self = [super init];
    if (self) {
        self.persistentContainer = persistentContainer;
    }
    return self;
}

- (void) getFavoritesWithPredicate: (NSPredicate*) predicate
                              onSuccess: (void(^)(NSArray* favorites)) successCallback
                                onError: (BlockWithError) errorCallback {
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName: @"Favorite" inManagedObjectContext: self.persistentContainer.viewContext];
    [request setEntity: description];
    if (predicate != nil) {
        [request setPredicate: predicate];
    }
    NSError* requestError = nil;
    NSPersistentStoreResult* result = [self.persistentContainer.viewContext executeRequest: request error: &requestError];
    if (requestError) {
        errorCallback(requestError);
    } else {
        NSArray* favorites = [result valueForKey: @"finalResult"];
        successCallback(favorites);
    }
}

- (void) getFavoritesWithSuccess: (void(^)(NSArray* characters)) successCallback
                         onError: (BlockWithError) errorCallback {
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"isFavorite = YES"];
    [self getFavoritesWithPredicate: predicate onSuccess: successCallback onError: errorCallback];
}

- (void) saveFavoriteFor: (NSString*) characterName
               withValue: (BOOL) value
               onSuccess: (EmptyBlock) onSuccess
                 onError: (BlockWithError) onError {
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"character.name = %@", characterName];
    [self getFavoritesWithPredicate: predicate onSuccess: ^(NSArray *favorites) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (favorites.count > 0) {
                [favorites[0] setIsFavorite: value];
                NSError* error = nil;
                [self.persistentContainer.viewContext save: nil];
                if (error != nil && onError != nil) {
                    onError(error);
                } else if (onSuccess != nil) {
                    onSuccess();
                }
            }
        });
    } onError: onError];
}

@end

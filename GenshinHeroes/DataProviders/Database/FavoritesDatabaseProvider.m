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
                         onSuccess: (BlockWithCharactersList) successCallback
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
        return;
    }
    if (successCallback != nil) {
        NSArray* favorites = [result valueForKey: @"finalResult"];
        successCallback(favorites);
    }
}

- (void) getFavoritesWithSuccess: (BlockWithCharactersList) successCallback
                         onError: (BlockWithError) errorCallback {
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"isFavorite = YES"];
    [self getFavoritesWithPredicate: predicate onSuccess: successCallback onError: errorCallback];
}

- (void) saveFavoriteFor: (Favorite*) favorite
               withValue: (BOOL) value
               onSuccess: (EmptyBlock) onSuccess
                 onError: (BlockWithError) onError {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [favorite setIsFavorite: value];
        NSError* error = nil;
        [self.persistentContainer.viewContext save: nil];
        if (error != nil && onError != nil) {
            onError(error);
        } else if (onSuccess != nil) {
            onSuccess();
        }
    });
}

@end

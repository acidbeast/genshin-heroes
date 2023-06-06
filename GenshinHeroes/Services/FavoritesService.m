//
//  FavoritesService.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/5/23.
//

#import "FavoritesService.h"

@interface FavoritesService ()

@property (weak, nonatomic) id <FavoritesDatabaseProviderProtocol> databaseProvider;

@end

@implementation FavoritesService

+ (instancetype) shared {
    static FavoritesService* service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[FavoritesService alloc] init];
    });
    return service;
}

- (instancetype) initWithDatabaseProvider: (id <FavoritesDatabaseProviderProtocol>) databaseProvider {
    self = [super init];
    if (self) {
        self.databaseProvider = databaseProvider;
    }
    return self;
};


- (void) getFavorites: (void(^)(NSArray* characters)) successCallback
                              onError: (BlockWitError) errorCallback {
    [self.databaseProvider getFavoritesWithSuccess: ^(NSArray * _Nonnull favorites) {
        successCallback([self convertToCharactersWith: favorites]);
    } onError: errorCallback];
}

- (void) saveFavorite: (Favorite*) favorite
            withValue: (BOOL) value
            onSuccess: (EmptyBlock) onSuccess
              onError: (BlockWitError) onError {
    [self.databaseProvider saveFavorite: favorite
                              withValue: value
                              onSuccess: (EmptyBlock) onSuccess
                                onError: (BlockWitError) onError];
}

- (void) saveCharacter: (Character*) character
     withFavoriteValue: (BOOL) favoriteValue
             onSuccess: (EmptyBlock) onSuccess
               onError: (BlockWitError) onError {
    [self.databaseProvider saveCharacter: character
                        withFavoriteValue: favoriteValue
                                onSuccess: (EmptyBlock) onSuccess
                                  onError: (BlockWitError) onError];
}


- (NSArray*) convertToCharactersWith: (NSArray*) favorites {
    NSMutableArray* result = [[NSMutableArray alloc] init];
    for (Favorite* favorite in favorites) {
        Character* character = favorite.character;
        [result addObject: character];
    }
    return [NSArray arrayWithArray: result];
}

@end

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

- (instancetype) initWithDatabaseProvider: (id <FavoritesDatabaseProviderProtocol>) databaseProvider {
    self = [super init];
    if (self) {
        self.databaseProvider = databaseProvider;
    }
    return self;
};


- (void) fetchFavorites: (void(^)(NSArray* characters)) successCallback
                              onError: (BlockWitError) errorCalback {
    // TODO: Pass callbacks
    [self.databaseProvider fetchFavorites];
}

- (void) saveCharacter: (Character*) character
     withFavoriteValue: (BOOL) favoriteValue
             onSuccess: (EmptyBlock) onSuccess
               onError: (BlockWitError) onError {
    [self.databaseProvider saveCharacter: (Character*) character
                       withFavoriteValue: (BOOL) favoriteValue
                               onSuccess: (EmptyBlock) onSuccess
                                 onError: (BlockWitError) onError];
}

@end

//
//  FavoritesVM.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/5/23.
//

#import "FavoritesVM.h"

typedef void (^FetchFavoritesErrorBlock)(NSError* error);

@interface FavoritesVM ()

@property (strong, nonatomic) id <FavoritesServiceProtocol> service;

@end

@implementation FavoritesVM

- (instancetype) initWithFavoritesService: (id <FavoritesServiceProtocol>) favoritesService {
    self = [super init];
    if (self) {
        self.service = favoritesService;
    }
    return self;
}

- (void) getFavorites {
    __weak FavoritesVM* weakSelf = self;
    [self.delegate onFetchFavoritesLoading];
    [self.service getFavorites: ^(NSArray * _Nonnull characters) {
        self.favorites = characters;
        [weakSelf.delegate onFetchFavoritesSuccess];
    } onError: ^(NSError *error) {
        [weakSelf.delegate onFetchFavoritesError: error];
    }];
}

- (void) saveFavorite: (Favorite*) favorite
            withValue: (BOOL) favoriteValue
             onSuccess: (EmptyBlock) onSuccess
               onError: (BlockWitError) onError {
    [self.service saveFavorite: favorite
                     withValue: favoriteValue
                     onSuccess: onSuccess
                       onError: onError];
}

@end

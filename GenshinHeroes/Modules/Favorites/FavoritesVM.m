//
//  FavoritesVM.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/5/23.
//

#import "FavoritesVM.h"

typedef void (^FetchFavoritesErrorBlock)(NSError* error);

@interface FavoritesVM ()

@property (weak, nonatomic) CharactersDatabaseProvider* coreDataService;
@property (copy, nonatomic) FetchFavoritesErrorBlock fetchFavoritesErrorBlock;

@end

@implementation FavoritesVM

- (instancetype) initWithcoreDataService: (CharactersDatabaseProvider*) coreDataService {
    self = [super init];
    if (self) {
        __weak FavoritesVM* weakSelf = self;
        self.coreDataService = coreDataService;
        self.fetchFavoritesErrorBlock = ^(NSError* error) {
            [weakSelf.delegate onFetchFavoritesError: error];
        };
    }
    return self;
}

- (void) fetchFavorites {
    self.favorites = [self.coreDataService fetchFavorites];
    [self.delegate onFetchFavoritesSuccess];
}

- (void) saveCharacter: (Character*) character
     withFavoriteValue: (BOOL) favoriteValue
             onSuccess:(EmptyBlock) onSuccess
               onError:(BlockWitError) onError {
    [self.coreDataService saveCharacter: character
                      withFavoriteValue: favoriteValue
                              onSuccess: onSuccess
                                onError: onError];
}

@end

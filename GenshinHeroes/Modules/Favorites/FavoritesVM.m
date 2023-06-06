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
//        __weak FavoritesVM* weakSelf = self;
//        self.fetchFavoritesErrorBlock = ^(NSError* error) {
//            [weakSelf.delegate onFetchFavoritesError: error];
//        };
    }
    return self;
}

- (void) fetchFavorites {
    __weak FavoritesVM* weakSelf = self;
    [self.service fetchFavorites: ^(NSArray * _Nonnull characters) {
        self.favorites = characters;
        [weakSelf.delegate onFetchFavoritesSuccess];
        NSLog(@"");
    } onError:^(NSError *error) {
        NSLog(@"");
    } ];
//    [self.delegate onFetchFavoritesSuccess];
}

- (void) saveCharacter: (Character*) character
     withFavoriteValue: (BOOL) favoriteValue
             onSuccess:(EmptyBlock) onSuccess
               onError:(BlockWitError) onError {
    [self.service saveCharacter: character
                      withFavoriteValue: favoriteValue
                              onSuccess: onSuccess
                                onError: onError];
}

@end

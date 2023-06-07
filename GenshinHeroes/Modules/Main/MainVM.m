//
//  MainVM.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/18/23.
//

#import "MainVM.h"

@interface MainVM ()

@property (strong, nonatomic) id <CharactersServiceProtocol> charactersService;
@property (strong, nonatomic) id <FavoritesServiceProtocol> favoritesService;

@end

@implementation MainVM

- (instancetype) initWithCharactersService: (id <CharactersServiceProtocol>) charactersService
                          favoritesService: (id <FavoritesServiceProtocol>) favoritesService {
    self = [super init];
    if (self) {
        self.charactersService = charactersService;
        self.favoritesService = favoritesService;
    }
    return self;
}

- (void) fetchCharacters {
    [self.delegate onFetchCharactersLoading];
    __weak MainVM* weakSelf = self;
    [self.charactersService getCharactersWithSuccess: ^(NSArray* characters) {
        self.characters = characters;
        [weakSelf.delegate onFetchCharactersSuccess];
    } onError: ^(NSError* error) {
        [weakSelf.delegate onFetchCharactersError: error];
    }];
}

- (void) saveFavoriteFor: (NSString*) characterName
               withValue: (BOOL) value
               onSuccess: (EmptyBlock) onSuccess
                 onError: (BlockWithError) onError {
    [self.favoritesService saveFavoriteFor: characterName
                                 withValue: value
                                 onSuccess: onSuccess
                                   onError: onError];
}

@end

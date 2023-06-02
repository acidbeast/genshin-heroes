//
//  MainVM.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/18/23.
//

#import "MainVM.h"

@interface MainVM ()

@property (strong, nonatomic) id <CharactersServiceProtocol> service;

@end

@implementation MainVM

- (instancetype) initWithService: (id <CharactersServiceProtocol>) service {
    self = [super init];
    if (self) {
        self.service = service;
    }
    return self;
}

- (void) fetchCharacters {
    [self.delegate onFetchCharactersLoading];
    __weak MainVM* weakSelf = self;
    [self.service getCharactersWithSuccess: ^(NSArray* characters) {
        self.characters = characters;
        [weakSelf.delegate onFetchCharactersSuccess];
    } onError: ^(NSError* error) {
        [weakSelf.delegate onFetchCharactersError: error];
    }];
}

- (void) saveCharacter: (Character*) character
     withFavoriteValue: (BOOL) favoriteValue
             onSuccess:(EmptyBlock) onSuccess
               onError:(BlockWitError) onError {
    NSLog(@"saveCharacter");
//    [self.coreDataService saveCharacter: character
//                      withFavoriteValue: favoriteValue
//                              onSuccess: onSuccess
//                                onError: onError];
}

@end

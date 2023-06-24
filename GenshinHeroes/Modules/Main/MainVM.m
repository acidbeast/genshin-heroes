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
@property (strong, nonatomic) id <NotificationsServiceProtocol> notificationsService;

@end

@implementation MainVM

- (instancetype) initWithCharactersService: (id <CharactersServiceProtocol>) charactersService
                          favoritesService: (id <FavoritesServiceProtocol>) favoritesService
                      notificationsService: (id <NotificationsServiceProtocol>) notificationsService {
    self = [super init];
    if (self) {
        self.charactersService = charactersService;
        self.favoritesService = favoritesService;
        self.notificationsService = notificationsService;
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

- (void) saveFavoriteFor: (Favorite*) favorite
               withValue: (BOOL) value
               onSuccess: (EmptyBlock) onSuccess
                 onError: (BlockWithError _Nullable) onError {
    __weak MainVM* weakSelf = self;
    [self.favoritesService saveFavoriteFor: favorite
                                 withValue: value
                                 onSuccess: onSuccess
                                   onError: ^(NSError* error) {
        [weakSelf.notificationsService showNotificationWithTitle: @"Network error" text: error.localizedDescription type: NotificationTypeError action: nil];
        if (onError != nil) {
            onError(error);
        }
    }];
}

@end

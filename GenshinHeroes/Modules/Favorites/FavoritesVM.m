//
//  FavoritesVM.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/5/23.
//

#import "FavoritesVM.h"

typedef void (^FetchFavoritesErrorBlock)(NSError* error);

@interface FavoritesVM ()

@property (strong, nonatomic) id <FavoritesServiceProtocol> favoritesService;
@property (strong, nonatomic) id <NotificationsServiceProtocol> notificationsService;

@end

@implementation FavoritesVM

- (instancetype) initWithFavoritesService: (id <FavoritesServiceProtocol>) favoritesService
                     notificationsService: (id <NotificationsServiceProtocol>) notificationService {
    self = [super init];
    if (self) {
        self.favoritesService = favoritesService;
        self.notificationsService = notificationService;
    }
    return self;
}

- (void) getFavorites {
    __weak FavoritesVM* weakSelf = self;
    [self.delegate onFetchFavoritesLoading];
    [self.favoritesService getFavorites: ^(NSArray * _Nonnull characters) {
        self.favorites = characters;
        [weakSelf.delegate onFetchFavoritesSuccess];
    } onError: ^(NSError *error) {
        [weakSelf.delegate onFetchFavoritesError: error];
        [weakSelf.notificationsService showNotificationWithTitle: @"Network error" text: error.localizedDescription type: NotificationTypeError action: nil];
    }];
}

- (void) saveFavoriteFor: (Favorite*) favorite
            withValue: (BOOL) value
             onSuccess: (EmptyBlock) onSuccess
               onError: (BlockWithError _Nullable) onError {
    __weak FavoritesVM* weakSelf = self;
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

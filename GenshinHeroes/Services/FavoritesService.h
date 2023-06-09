//
//  FavoritesService.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/5/23.
//

#import <Foundation/Foundation.h>
#import "FavoritesDatabaseProvider.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FavoritesServiceProtocol

- (void) getFavorites: (void(^)(NSArray* characters)) successCallback
                              onError: (BlockWithError) errorCalback;
- (void) saveFavoriteFor: (Favorite*) favorite
               withValue: (BOOL) value
               onSuccess: (EmptyBlock) onSuccess
                 onError: (BlockWithError) onError;

@end


@interface FavoritesService : NSObject <FavoritesServiceProtocol>

- (instancetype) initWithDatabaseProvider: (id <FavoritesDatabaseProviderProtocol>) databaseProvider;
- (void) getFavorites: (void(^)(NSArray* characters)) successCallback
                              onError: (BlockWithError) errorCalback;
- (void) saveFavoriteFor: (Favorite*) favorite
               withValue: (BOOL) value
               onSuccess: (EmptyBlock) onSuccess
                 onError: (BlockWithError) onError;

@end

NS_ASSUME_NONNULL_END

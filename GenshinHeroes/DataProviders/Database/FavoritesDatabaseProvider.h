//
//  FavoritesDatabaseProvider.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/5/23.
//

#import <Foundation/Foundation.h>
#import "DatabaseProvider.h"
#import "Character+CoreDataClass.h"
#import "Favorite+CoreDataClass.h"
#import "Blocks.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FavoritesDatabaseProviderProtocol

- (void) getFavoritesWithSuccess: (void(^)(NSArray* characters)) successCallback
                         onError: (BlockWitError) errorCallback;
- (void) saveCharacter: (Character*) character
     withFavoriteValue: (BOOL) favoriteValue
             onSuccess: (EmptyBlock) onSuccess
               onError: (BlockWitError) onError;

@end

@interface FavoritesDatabaseProvider : DatabaseProvider <FavoritesDatabaseProviderProtocol>

+ (instancetype) shared;
- (void) getFavoritesWithSuccess: (void(^)(NSArray* characters)) successCallback
                         onError: (BlockWitError) errorCallback;
- (void) saveCharacter: (Character*) character
     withFavoriteValue: (BOOL) favoriteValue
             onSuccess: (EmptyBlock) onSuccess
               onError: (BlockWitError) onError;
@end

NS_ASSUME_NONNULL_END

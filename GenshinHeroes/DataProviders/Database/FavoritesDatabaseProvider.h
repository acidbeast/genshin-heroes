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
                         onError: (BlockWithError) errorCallback;
- (void) saveFavoriteFor: (Favorite*) favorite
               withValue: (BOOL) value
               onSuccess: (EmptyBlock) onSuccess
                 onError: (BlockWithError) onError;

@end

@interface FavoritesDatabaseProvider : NSObject <FavoritesDatabaseProviderProtocol>

- (instancetype) initWithPersistentContainer: (NSPersistentContainer*) persistentContainer;
- (void) getFavoritesWithSuccess: (void(^)(NSArray* characters)) successCallback
                         onError: (BlockWithError) errorCallback;
- (void) saveFavoriteFor: (Favorite*) favorite
               withValue: (BOOL) value
               onSuccess: (EmptyBlock) onSuccess
                 onError: (BlockWithError) onError;
@end

NS_ASSUME_NONNULL_END

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

- (NSArray*) fetchFavorites;
- (void) saveCharacter: (Character*) character
     withFavoriteValue: (BOOL) favoriteValue
             onSuccess: (EmptyBlock) onSuccess
               onError: (BlockWitError) onError;

@end

@interface FavoritesDatabaseProvider : DatabaseProvider <FavoritesDatabaseProviderProtocol>

+ (instancetype) shared;
- (NSArray*) fetchFavorites;
- (void) saveCharacter: (Character*) character
     withFavoriteValue: (BOOL) favoriteValue
             onSuccess: (EmptyBlock) onSuccess
               onError: (BlockWitError) onError;
@end

NS_ASSUME_NONNULL_END

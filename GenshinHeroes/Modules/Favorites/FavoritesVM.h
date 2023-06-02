//
//  FavoritesVM.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/5/23.
//

#import <Foundation/Foundation.h>
#import "CharactersDatabaseProvider.h"
#import "Character+CoreDataClass.h"
#import "Favorite+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FavoritesVMDelegateProtocol <NSObject>

- (void) onFetchFavoritesLoading;
- (void) onFetchFavoritesSuccess;
- (void) onFetchFavoritesError: (NSError*) error;

@end


@interface FavoritesVM : NSObject

@property (strong, nonatomic) NSArray* favorites;
@property (weak, nonatomic) id <FavoritesVMDelegateProtocol> delegate;

- (instancetype) initWithcoreDataService: (CharactersDatabaseProvider*) coreDataService;
- (void) fetchFavorites;
- (void) saveCharacter: (Character*) character
     withFavoriteValue: (BOOL) favoriteValue
             onSuccess:(EmptyBlock) onSuccess
               onError:(BlockWitError) onError;

@end

NS_ASSUME_NONNULL_END

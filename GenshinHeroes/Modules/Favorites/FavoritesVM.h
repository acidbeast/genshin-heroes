//
//  FavoritesVM.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/5/23.
//

#import <Foundation/Foundation.h>
#import "Character+CoreDataClass.h"
#import "Favorite+CoreDataClass.h"
#import "FavoritesService.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FavoritesVMDelegateProtocol <NSObject>

- (void) onFetchFavoritesLoading;
- (void) onFetchFavoritesSuccess;
- (void) onFetchFavoritesError: (NSError*) error;

@end


@interface FavoritesVM : NSObject

@property (strong, nonatomic) NSArray* favorites;
@property (weak, nonatomic) id <FavoritesVMDelegateProtocol> delegate;

- (instancetype) initWithFavoritesService: (id <FavoritesServiceProtocol>) favoritesService;
- (void) getFavorites;
- (void) saveFavoriteFor: (Favorite*) favorite
               withValue: (BOOL) value
               onSuccess: (EmptyBlock) onSuccess
                 onError: (BlockWithError) onError;

@end

NS_ASSUME_NONNULL_END

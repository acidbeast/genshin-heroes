//
//  MainVM.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/18/23.
//

#import <Foundation/Foundation.h>
#import "CharactersService.h"
#import "FavoritesService.h"
#import "Character+CoreDataClass.h"
#import "Favorite+CoreDataClass.h"
#import "Blocks.h"

NS_ASSUME_NONNULL_BEGIN

@class CharactersService;
@class FavoritesService;

@protocol MainVMDelegateProtocol <NSObject>

- (void) onFetchCharactersLoading;
- (void) onFetchCharactersSuccess;
- (void) onFetchCharactersError: (NSError*) error;

@end

@interface MainVM : NSObject

@property (strong, nonatomic) NSArray* characters;
@property (weak, nonatomic) id <MainVMDelegateProtocol> delegate;

- (instancetype) initWithCharactersService: (id <CharactersServiceProtocol>) charactersService
                          favoritesService: (id <FavoritesServiceProtocol>) favoritesService;
- (void) fetchCharacters;
- (void) saveCharacter: (Character*) character
     withFavoriteValue: (BOOL) favoriteValue
             onSuccess: (EmptyBlock) onSuccess
               onError: (BlockWitError) onError;
- (void) saveFavorite: (Favorite*) favorite
            withValue: (BOOL) favoriteValue
            onSuccess: (EmptyBlock) onSuccess
              onError: (BlockWitError) onError;

@end

NS_ASSUME_NONNULL_END

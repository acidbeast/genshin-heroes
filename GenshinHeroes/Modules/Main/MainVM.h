//
//  MainVM.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/18/23.
//

#import <Foundation/Foundation.h>
//#import "SettingsProvider.h"
#import "CharactersService.h"
//#import "CharactersNetworkProvider.h"
//#import "CharactersDatabaseProvider.h"
#import "Character+CoreDataClass.h"
#import "Favorite+CoreDataClass.h"
#import "Blocks.h"

NS_ASSUME_NONNULL_BEGIN

//@class SettingsProvider;
@class CharactersService;
//@class CharactersNetworkProvider;

@protocol MainVMDelegateProtocol <NSObject>

- (void) onFetchCharactersLoading;
- (void) onFetchCharactersSuccess;
- (void) onFetchCharactersError: (NSError*) error;

@end

@interface MainVM : NSObject

@property (strong, nonatomic) NSArray* characters;
@property (weak, nonatomic) id <MainVMDelegateProtocol> delegate;

- (instancetype) initWithService: (id <CharactersServiceProtocol>) service;
- (void) fetchCharacters;
- (void) saveCharacter: (Character*) character
     withFavoriteValue: (BOOL) favoriteValue
             onSuccess:(EmptyBlock) onSuccess
               onError:(BlockWitError) onError;

@end

NS_ASSUME_NONNULL_END

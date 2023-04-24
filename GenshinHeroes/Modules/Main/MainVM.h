//
//  MainVM.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/18/23.
//

#import <Foundation/Foundation.h>
#import "SettingsService.h"
#import "CharactersService.h"
#import "CoreDataService.h"

NS_ASSUME_NONNULL_BEGIN

@class SettingsService;
@class CharactersService;

@protocol MainVMDelegateProtocol <NSObject>

- (void) onFetchCharactersLoading;
- (void) onFetchCharactersSuccess;
- (void) onFetchCharactersError: (NSError*) error;

@end

@interface MainVM : NSObject

@property (strong, nonatomic) NSArray* characters;
@property (weak, nonatomic) id <MainVMDelegateProtocol> delegate;

- (instancetype) initWithSettingsService: (SettingsService*) settingsService
                        characterService: (CharactersService*) charactersService
                         coreDataService: (CoreDataService*) coreDataService;
- (void) fetchCharacters;

@end

NS_ASSUME_NONNULL_END

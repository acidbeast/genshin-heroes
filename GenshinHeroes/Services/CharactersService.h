//
//  CharactersNewService.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/2/23.
//

#import <Foundation/Foundation.h>
#import "Blocks.h"
#import "Character+CoreDataClass.h"

#import "CharactersNetworkProvider.h"
#import "CharactersDatabaseProvider.h"
#import "SettingsProvider.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CharactersServiceProtocol <NSObject>

- (void) getCharactersWithSuccess: (void(^)(NSArray* characters)) successCallback
                          onError: (BlockWithError) errorCalback;
- (void) getCharacterWithName: (NSString*) name
                    onSuccess: (BlockWithCharacter) successCallback
                      onError: (BlockWithError) errorCallback;

@end

@interface CharactersService : NSObject <CharactersServiceProtocol>

+ (instancetype) shared;
- (instancetype) initWithNetworkProvider: (id <CharactersNetworkProviderProtocol>) networkProvider
                        databaseProvider: (id <CharactersDatabaseProviderProtocol>) databaseProvider
                         settingsPrvider: (id <SettingsProviderProtocol>) settingsProvider;
- (void) getCharactersWithSuccess: (BlockWithCharactersList) successCallback
                          onError: (BlockWithError) errorCalback;
- (void) getCharacterWithName: (NSString*) name
                    onSuccess: (BlockWithCharacter) successCallback
                      onError: (BlockWithError) errorCallback;

@end

NS_ASSUME_NONNULL_END

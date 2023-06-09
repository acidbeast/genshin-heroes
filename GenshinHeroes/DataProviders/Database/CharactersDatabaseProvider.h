//
//  CoreDataService.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/21/23.
//

#import <Foundation/Foundation.h>
#import "DatabaseProvider.h"
#import "Character+CoreDataClass.h"
#import "Nation+CoreDataClass.h"
#import "SkillTalent+CoreDataClass.h"
#import "SkillTalentType+CoreDataClass.h"
#import "Vision+CoreDataClass.h"
#import "Weapon+CoreDataClass.h"
#import "Favorite+CoreDataClass.h"
#import "Blocks.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CharactersDatabaseProviderProtocol

- (void) getCharactersWithSuccess: (BlockWithCharactersList) successCallback
                          onError: (BlockWithError) errorCallback;
- (void) saveCharactersWith: (NSDictionary*) characters
                  onSuccess: (EmptyBlock) onSuccess
                    onError: (BlockWithError) onError;
- (void) getCharacterWithName: (NSString*) name
                    onSuccess: (BlockWithCharacter) successCallback
                      onError: (BlockWithError) errorCallback;
@end


@interface CharactersDatabaseProvider : NSObject <CharactersDatabaseProviderProtocol>

- (instancetype) initWithPersistentContainer: (NSPersistentContainer*) persistentContainer;
- (void) getCharactersWithSuccess: (BlockWithCharactersList) successCallback
                          onError: (BlockWithError) errorCallback;
- (void) saveCharactersWith: (NSDictionary*) characters
                  onSuccess: (EmptyBlock) onSuccess
                    onError: (BlockWithError) onError;
- (void) getCharacterWithName: (NSString*) name
                    onSuccess: (BlockWithCharacter) successCallback
                      onError: (BlockWithError) errorCallback;

@end

NS_ASSUME_NONNULL_END

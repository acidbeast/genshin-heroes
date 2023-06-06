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

- (NSArray*) getCharacters;
- (Character*) getCharacterWithName: (NSString*) name;
- (void) saveCharactersWith: (NSDictionary*) characters
                  onSuccess: (void(^)(void)) onSuccess
                    onError: (void(^)(NSError* error)) onError;

@end


@interface CharactersDatabaseProvider : DatabaseProvider <CharactersDatabaseProviderProtocol>

+ (instancetype) shared;
- (void) saveCharactersWith: (NSDictionary*) characters
                  onSuccess: (void(^)(void)) onSuccess
                    onError: (void(^)(NSError* error)) onError;
- (NSArray*) getCharacters;
- (void) saveCharacter: (Character*) character
     withFavoriteValue: (BOOL) favoriteValue
             onSuccess: (EmptyBlock) onSuccess
               onError: (BlockWitError) onError;
- (Character*) getCharacterWithName: (NSString*) name;
- (void) saveContext;

@end

NS_ASSUME_NONNULL_END

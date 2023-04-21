//
//  CoreDataService.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/21/23.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Character+CoreDataClass.h"
#import "Nation+CoreDataClass.h"
#import "SkillTalent+CoreDataClass.h"
#import "SkillTalentType+CoreDataClass.h"
#import "Vision+CoreDataClass.h"
#import "Weapon+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataService : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+ (instancetype) shared;
- (void) saveCharactersWith: (NSDictionary*) characters
                  onSuccess: (void(^)(NSArray<Character*>* characters)) onSuccess
                    onError: (void(^)(NSError* error)) onError;
- (void) saveContext;

@end

NS_ASSUME_NONNULL_END

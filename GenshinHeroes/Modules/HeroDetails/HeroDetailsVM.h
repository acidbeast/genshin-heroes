//
//  HeroDetailsVM.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/19/23.
//

#import <Foundation/Foundation.h>
#import "CoreDataService.h"
#import "Character+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeroDetailsVM : NSObject

@property (strong, nonatomic) NSString* heroName;
@property (strong, nonatomic) Character* hero;

- (instancetype) initWithHeroName: (NSString*) heroName
                  coreDataService: (CoreDataService*) coreDataService;

- (void) getHeroDetails;

@end

NS_ASSUME_NONNULL_END

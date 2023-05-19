//
//  HeroDetailsVM.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/19/23.
//

#import "HeroDetailsVM.h"

@interface HeroDetailsVM ()

@property (weak, nonatomic) CoreDataService* coreDataService;

@end

@implementation HeroDetailsVM

- (instancetype) initWithHeroName: (NSString*) heroName
                  coreDataService: (CoreDataService*) coreDataService {
    self = [super init];
    if (self) {
        self.heroName = heroName;
        self.coreDataService = coreDataService;
    }
    return self;
}

- (void) getHeroDetails {
    self.hero = [self.coreDataService getCharacterWithName: self.heroName];
    NSLog(@"getHeroDetails: %@", self.hero);
}

@end

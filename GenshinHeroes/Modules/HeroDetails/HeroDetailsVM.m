//
//  HeroDetailsVM.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/19/23.
//

#import "HeroDetailsVM.h"

@interface HeroDetailsVM ()

@property (strong, nonatomic) NSString* heroName;

@end

@implementation HeroDetailsVM

- (instancetype) initWithHeroName: (NSString*) heroName {
    self = [super init];
    if (self) {
        self.heroName = heroName;
    }
    return self;
}


@end

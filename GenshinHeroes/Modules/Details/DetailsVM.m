//
//  HeroDetailsVM.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/19/23.
//

#import "DetailsVM.h"

@interface DetailsVM ()

@property (weak, nonatomic) CoreDataService* coreDataService;

@end

@implementation DetailsVM

- (instancetype) initWithHeroName: (NSString*) heroName
                  coreDataService: (CoreDataService*) coreDataService {
    self = [super init];
    if (self) {
        self.heroName = heroName;
        self.coreDataService = coreDataService;
        self.sections = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) getHeroDetails {
    self.hero = [self.coreDataService getCharacterWithName: self.heroName];
    [self createSectionsWith: self.hero];
}


- (void) createSectionsWith: (Character*) hero {
    DetailsSection* imageSection = [[DetailsSection alloc] initWithType: DetailsSectionTypeImage imageName: [self heroImageWithName: hero.name suffix: @"big"]];
    DetailsSection* titleSection = [[DetailsSection alloc] initWithType: DetailsSectionTypeTitle title: hero.name];
    DetailsSection* ratingSection = [[DetailsSection alloc] initWithType: DetailsSectionTypeRating rating: hero.rarity];
    DetailsSection* textSection = [[DetailsSection alloc] initWithType: DetailsSectionTypeText text: hero.about];
    [self.sections addObject: imageSection];
    [self.sections addObject: titleSection];
    [self.sections addObject: ratingSection];
    [self.sections addObject: textSection];
}

- (NSString*) heroImageWithName: (NSString*) name suffix: (NSString*) suffix {
    NSString* lowerCasedName = [[name stringByReplacingOccurrencesOfString: @" " withString: @"-"] lowercaseString];
    NSString* imageName = [NSString stringWithFormat: @"%@-big", lowerCasedName];
    return imageName;
}

@end

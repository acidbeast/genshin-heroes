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
    NSLog(@"getHeroDetails: %@", self.hero);
    [self createSectionsWith: self.hero];
    NSLog(@"sections %@", self.sections);
}


- (void) createSectionsWith: (Character*) hero {
    DetailsSection* imageSection = [[DetailsSection alloc] initWithType: DetailsSectionTypeImage imageName: @"imageUrl"];
    DetailsSection* titleSection = [[DetailsSection alloc] initWithType: DetailsSectionTypeTitle title: hero.name];
    DetailsSection* ratingSection = [[DetailsSection alloc] initWithType: DetailsSectionTypeRating rating: 0];
    DetailsSection* textSection = [[DetailsSection alloc] initWithType: DetailsSectionTypeTitle text: @"text 1"];
    [self.sections addObject: imageSection];
    [self.sections addObject: titleSection];
    [self.sections addObject: ratingSection];
    [self.sections addObject: textSection];
}

@end

//
//  HeroDetailsVM.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/19/23.
//

#import "DetailsVM.h"

@interface DetailsVM ()

@property (weak, nonatomic) id <CharactersServiceProtocol> charactersService;
@property (weak, nonatomic) id <FavoritesServiceProtocol> favoritesService;

@end

@implementation DetailsVM

- (instancetype) initWithHeroName: (NSString*) heroName
                  charactersService: (id <CharactersServiceProtocol>) charactersService
                  favoritesService: (id <FavoritesServiceProtocol>) favoritesService {
    self = [super init];
    if (self) {
        self.heroName = heroName;
        self.charactersService = charactersService;
        self.favoritesService = favoritesService;
        self.sections = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) getHeroDetails {
    __weak DetailsVM* weakSelf = self;
    [self.charactersService getCharacterWithName: self.heroName
                                                   onSuccess: ^(Character* character) {
        weakSelf.hero = character;
        [self createSectionsWith: weakSelf.hero];
    }
                                                     onError:^(NSError *error) {
        // TODO: show error;
    }];
}


- (void) createSectionsWith: (Character*) hero {
    DetailsSection* imageSection = [[DetailsSection alloc] initWithType: DetailsSectionTypeImage imageName: [self heroImageWithName: hero.name suffix: @"big"] isFavorite: hero.favorite.isFavorite];
    DetailsSection* titleSection = [[DetailsSection alloc] initWithType: DetailsSectionTypeTitle title: hero.name];
    DetailsSection* ratingSection = [[DetailsSection alloc] initWithType: DetailsSectionTypeRating rating: hero.rarity];
    DetailsSection* textSection = [[DetailsSection alloc] initWithType: DetailsSectionTypeText text: hero.about];
    DetailsSection* visionSection = [[DetailsSection alloc] initWithType: DetailsSectionTypeTwoColumns title: @"Vision" value: hero.vision.name background: YES];
    DetailsSection* weaponSection = [[DetailsSection alloc] initWithType: DetailsSectionTypeTwoColumns title: @"Weapon" value: hero.weapon.name background: NO];
    DetailsSection* nationSection = [[DetailsSection alloc] initWithType: DetailsSectionTypeTwoColumns title: @"Nation" value: hero.nation.name background: YES];
    DetailsSection* affiliationSection = [[DetailsSection alloc] initWithType: DetailsSectionTypeTwoColumns title: @"Affiliation" value: hero.affiliation background: NO];
    DetailsSection* constellationSection = [[DetailsSection alloc] initWithType: DetailsSectionTypeTwoColumns title: @"Constelatlion" value: hero.constellation background: YES];
    DetailsSection* birthdaySection = [[DetailsSection alloc] initWithType: DetailsSectionTypeTwoColumns title: @"Birthday" value: [self formatDate: hero.birthday] background: NO];
    [self.sections addObject: imageSection];
    [self.sections addObject: titleSection];
    [self.sections addObject: ratingSection];
    [self.sections addObject: textSection];
    [self.sections addObject: visionSection];
    [self.sections addObject: weaponSection];
    [self.sections addObject: nationSection];
    [self.sections addObject: affiliationSection];
    [self.sections addObject: constellationSection];
    [self.sections addObject: birthdaySection];
}

- (NSString*) heroImageWithName: (NSString*) name suffix: (NSString*) suffix {
    NSString* lowerCasedName = [[name stringByReplacingOccurrencesOfString: @" " withString: @"-"] lowercaseString];
    NSString* imageName = [NSString stringWithFormat: @"%@-big", lowerCasedName];
    return imageName;
}

- (NSString*) formatDate: (NSString*) dateString {
    NSDateFormatter* dateFormatterIn = [[NSDateFormatter alloc] init];
    dateFormatterIn.dateFormat = @"0000-MM-dd";
    NSDateFormatter* dateFormatterOut = [[NSDateFormatter alloc] init];
    dateFormatterOut.dateFormat = @"MM/dd";
    NSDate* date = [dateFormatterIn dateFromString: dateString];
    return [dateFormatterOut stringFromDate: date];
}

- (void) saveFavoriteWithSuccess: (void(^)(BOOL newValue)) successCallback
                         onError: (BlockWithError) errorCallback {
    BOOL newValue = !self.hero.favorite.isFavorite;
    [self.favoritesService saveFavoriteFor: self.heroName
                                 withValue: newValue
                                 onSuccess:^{
        if (successCallback != nil) {
            successCallback(newValue);
        }
    }
                                   onError: errorCallback];
}

@end

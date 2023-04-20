//
//  MainVM.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/18/23.
//

#import "MainVM.h"
#import "SettingsService.h"
#import "CharactersService.h"

@interface MainVM ()

@property (weak, nonatomic) SettingsService* settingsService;
@property (weak, nonatomic) CharactersService* charactersService;

@end

@implementation MainVM

- (instancetype) initWithSettingsService: (SettingsService*) settingsService
                        characterService: (CharactersService*) charactersService {
    self = [super init];
    if (self) {
        self.settingsService = settingsService;
        self.charactersService = charactersService;
    }
    return self;
}

- (void) fetchCharacters {
//    Temporary here to emulate different dates
//    NSDate* newDate = [[NSDate alloc] initWithTimeIntervalSinceNow: -1900000];
//    [self.settingsService saveCacheExpirationDate: newDate];
    BOOL cacheIsExpired = [self cacheIsExpired];
    NSLog(@"cacheIsExpired %@", cacheIsExpired ? @"YES" : @"NO");
    if (cacheIsExpired == YES) {
        [self.charactersService getCharactersWithSuccess: ^(NSDictionary* characters) {
            NSLog(@"success %@", characters);
            // Run CoreDataManager save data
            // Run CoreDataManger load data on save data success.
        } onError:^(NSError* error) {
            // Run delegate onError method (delegate is mainVC which shows error in UI.
            NSLog(@"Error %@", error);
        }];
    } else {
        // run CoreDataManger load data
    }
}

- (NSDate*) fetchCacheDate {
    NSDate* cacheDate = [self.settingsService loadCacheExpirationDateDate];
    if (cacheDate == nil) {
        NSDate* newDate = [[NSDate alloc] initWithTimeIntervalSinceNow: 0];
        [self.settingsService saveCacheExpirationDate: newDate];
        return newDate;
    }
    return cacheDate;
}

- (BOOL) cacheIsExpired {
    NSDate* cacheDate = [self fetchCacheDate];
    NSDate* dateNow = [[NSDate alloc] initWithTimeIntervalSinceNow: 0];
    NSTimeInterval secondsBetweenDates = [dateNow timeIntervalSinceDate: cacheDate];
    NSInteger daysBetweenDates = (int)secondsBetweenDates / (60 * 60 * 24);
    return daysBetweenDates > 14 ? YES : NO;
}

@end

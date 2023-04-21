//
//  MainVM.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/18/23.
//

#import "MainVM.h"

typedef void (^FetchCharactersErrorBlock)(NSError* error);

@interface MainVM ()

@property (weak, nonatomic) SettingsService* settingsService;
@property (weak, nonatomic) CharactersService* charactersService;
@property (weak, nonatomic) CoreDataService* coreDataService;
@property (copy, nonatomic) FetchCharactersErrorBlock fetchCharactersErrorBlock;

@end

@implementation MainVM

- (instancetype) initWithSettingsService: (SettingsService*) settingsService
                        characterService: (CharactersService*) charactersService
                         coreDataService: (CoreDataService*) coreDataService {
    self = [super init];
    if (self) {
        __weak MainVM* weakSelf = self;
        self.settingsService = settingsService;
        self.charactersService = charactersService;
        self.coreDataService = coreDataService;
        self.fetchCharactersErrorBlock = ^(NSError* error) {
            NSLog(@"Error %@", error);
            // [weakSelf runDelegateErrorCallback: error];
        };
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
            [self.coreDataService saveCharactersWith: characters
                                           onSuccess: ^(NSArray* characters) {
                // Run CoreDataManger load data on save data success.
            }
                                             onError: self.fetchCharactersErrorBlock];
        } onError: self.fetchCharactersErrorBlock];
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

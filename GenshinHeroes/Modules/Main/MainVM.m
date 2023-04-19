//
//  MainVM.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/18/23.
//

#import "MainVM.h"
#import "SettingsService.h"


@interface MainVM ()

@property (weak, nonatomic) SettingsService* settingsService;

@end

@implementation MainVM

- (instancetype) initWithSettingsService: (SettingsService*) settingsService {
    self = [super init];
    if (self) {
        self.settingsService = settingsService;
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
        NSLog(@"fetch from API, put to CoreData, and then read");
    } else {
        NSLog(@"Read characters from CoreData");
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

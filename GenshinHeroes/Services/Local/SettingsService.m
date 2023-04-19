//
//  SettingsService.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/18/23.
//

#import "SettingsService.h"

@interface SettingsService ()

@property (strong, nonatomic) NSUserDefaults* userDefaults;

@end

@implementation SettingsService

static NSString* const kSettingsCacheExpirationDate = @"settings.cache.expirationDate";

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

+ (SettingsService*) shared {
    static SettingsService* settingsService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settingsService = [[SettingsService alloc] init];
    });
    return settingsService;
}

- (void) saveCacheExpirationDate: (NSDate*) date {
    NSDate* dateToSave = nil;
    if (date) {
        dateToSave = date;
    } else {
        dateToSave = [[NSDate alloc] initWithTimeIntervalSinceNow: 0];
    }
    [self.userDefaults setObject: dateToSave forKey: kSettingsCacheExpirationDate];
}

- (NSDate*) loadCacheExpirationDateDate {
    return [self.userDefaults objectForKey: kSettingsCacheExpirationDate];
}


@end

//
//  SettingsProvider.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/18/23.
//

#import "SettingsProvider.h"

@interface SettingsProvider ()

@property (strong, nonatomic) NSUserDefaults* userDefaults;

@end

@implementation SettingsProvider

static NSString* const kSettingsCacheExpirationDate = @"settings.cache.expirationDate";

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

+ (SettingsProvider*) shared {
    static SettingsProvider* settingsService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settingsService = [[SettingsProvider alloc] init];
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

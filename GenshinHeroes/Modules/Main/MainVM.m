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

- (void) fetchCacheDate {
    NSDate* cacheDate = [self.settingsService loadCacheExpirationDateDate];
    NSLog(@"cacheDate %@", cacheDate);
}


@end

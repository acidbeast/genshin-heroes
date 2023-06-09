//
//  CharactersNewService.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/2/23.
//

#import "CharactersService.h"

@interface CharactersService ()

@property (weak, nonatomic) id <CharactersNetworkProviderProtocol> networkProvider;
@property (weak, nonatomic) id <CharactersDatabaseProviderProtocol> databaseProvider;
@property (weak, nonatomic) id <SettingsProviderProtocol> settingsProvider;

@end

@implementation CharactersService

- (instancetype) initWithNetworkProvider: (id <CharactersNetworkProviderProtocol>) networkProvider
                        databaseProvider: (id <CharactersDatabaseProviderProtocol>) databaseProvider
                         settingsPrvider: (id <SettingsProviderProtocol>) settingsProvider {
    self = [super init];
    if (self) {
        self.networkProvider = networkProvider;
        self.databaseProvider = databaseProvider;
        self.settingsProvider = settingsProvider;
    }
    return self;
}

- (void) getCharactersWithSuccess: (BlockWithCharactersList) successCallback
                          onError: (BlockWithError) errorCallback {
    BOOL cacheIsExpired = [self cacheIsExpired];
    if (cacheIsExpired == YES) {
        [self.networkProvider getCharactersWithSuccess: ^(NSDictionary* characters) {
            [self.databaseProvider saveCharactersWith: characters
                                            onSuccess: ^(void) {
                [self setCacheExpirationDateNow];
                [self.databaseProvider getCharactersWithSuccess: successCallback onError: errorCallback];
            }
                                             onError: errorCallback];
        } onError: errorCallback];
    } else {
        [self.databaseProvider getCharactersWithSuccess: successCallback onError: errorCallback];
    }
}

- (BOOL) cacheIsExpired {
    NSDate* cacheDate = [self fetchCacheDate];
    NSDate* dateNow = [[NSDate alloc] initWithTimeIntervalSinceNow: 0];
    NSTimeInterval secondsBetweenDates = [dateNow timeIntervalSinceDate: cacheDate];
    NSInteger daysBetweenDates = (int)secondsBetweenDates / (60 * 60 * 24);
    if (daysBetweenDates == NAN) { return YES; }
    return daysBetweenDates > 14 ? YES : NO;
}

- (NSDate*) fetchCacheDate {
    NSDate* cacheDate = [self.settingsProvider loadCacheExpirationDateDate];
    if (cacheDate == nil) {
        NSDate* newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate: 0];
        [self.settingsProvider saveCacheExpirationDate: newDate];
        return newDate;
    }
    return cacheDate;
}

- (void) setCacheExpirationDateNow {
    NSDate* newDate = [[NSDate alloc] initWithTimeIntervalSinceNow: 0];
    [self.settingsProvider saveCacheExpirationDate: newDate];
}

- (void) getCharacterWithName: (NSString*) name
                    onSuccess: (BlockWithCharacter) successCallback
                      onError: (BlockWithError) errorCallback {
    [self.databaseProvider getCharacterWithName: name
                                      onSuccess: successCallback
                                        onError: errorCallback];
}

@end

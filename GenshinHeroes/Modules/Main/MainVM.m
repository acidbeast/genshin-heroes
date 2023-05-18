//
//  MainVM.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/18/23.
//

#import "MainVM.h"

@interface MainVM ()

@property (weak, nonatomic) SettingsService* settingsService;
@property (weak, nonatomic) CharactersService* charactersService;
@property (weak, nonatomic) CoreDataService* coreDataService;
@property (copy, nonatomic) BlockWitError fetchCharactersErrorBlock;

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
            [weakSelf.delegate onFetchCharactersError: error];
        };
    }
    return self;
}

- (NSDate*) fetchCacheDate {
    NSDate* cacheDate = [self.settingsService loadCacheExpirationDateDate];
    if (cacheDate == nil) {
        NSDate* newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate: 0];
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
    if (daysBetweenDates == NAN) { return YES; }
    return daysBetweenDates > 14 ? YES : NO;
}

- (void) fetchCharacters {
    [self.delegate onFetchCharactersLoading];
    __weak MainVM* weakSelf = self;
    
    // TODO: Remove when app will be done.
//    [self.settingsService saveCacheExpirationDate: [[NSDate alloc] initWithTimeIntervalSinceReferenceDate: 90000]];
    
    BOOL cacheIsExpired = [self cacheIsExpired];
    if (cacheIsExpired == YES) {
        [self.charactersService getCharactersWithSuccess: ^(NSDictionary* characters) {
            [self.coreDataService saveCharactersWith: characters
                                           onSuccess: ^(void) {
                self.characters = [self.coreDataService getCharacters];
                [self setCacheExpirationDateNow];
                [weakSelf.delegate onFetchCharactersSuccess];
            }
                                             onError: self.fetchCharactersErrorBlock];
        } onError: self.fetchCharactersErrorBlock];
    } else {
        self.characters = [self.coreDataService getCharacters];
        // TODO: check amount of characters, if 0, try to request again.
        [weakSelf.delegate onFetchCharactersSuccess];
    }
}

- (void) setCacheExpirationDateNow {
    NSDate* newDate = [[NSDate alloc] initWithTimeIntervalSinceNow: 0];
    [self.settingsService saveCacheExpirationDate: newDate];
}

- (void) saveCharacter: (Character*) character
     withFavoriteValue: (BOOL) favoriteValue
             onSuccess:(EmptyBlock) onSuccess
               onError:(BlockWitError) onError {
    [self.coreDataService saveCharacter: character
                      withFavoriteValue: favoriteValue
                              onSuccess: onSuccess
                                onError: onError];
}

@end

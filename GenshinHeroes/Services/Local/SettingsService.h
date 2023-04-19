//
//  SettingsService.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/18/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SettingsServiceProtocol <NSObject>

- (void) saveCacheExpirationDate: (NSDate*) date;
- (NSDate*) loadCacheExpirationDateDate;

@end

@interface SettingsService : NSObject <SettingsServiceProtocol>

+ (SettingsService*) shared;
- (void) saveCacheExpirationDate: (NSDate*) date;
- (NSDate*) loadCacheExpirationDateDate;

@end

NS_ASSUME_NONNULL_END

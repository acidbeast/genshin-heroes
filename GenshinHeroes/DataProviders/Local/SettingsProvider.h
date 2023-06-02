//
//  SettingsProvider.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/18/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SettingsProviderProtocol <NSObject>

- (void) saveCacheExpirationDate: (NSDate*) date;
- (NSDate*) loadCacheExpirationDateDate;

@end

@interface SettingsProvider : NSObject <SettingsProviderProtocol>

+ (SettingsProvider*) shared;
- (void) saveCacheExpirationDate: (NSDate*) date;
- (NSDate*) loadCacheExpirationDateDate;

@end

NS_ASSUME_NONNULL_END

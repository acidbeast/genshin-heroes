//
//  MainVM.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/18/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SettingsService;

@interface MainVM : NSObject

- (instancetype) initWithSettingsService: (SettingsService*) settingsService;
- (void) fetchCharacters;

@end

NS_ASSUME_NONNULL_END

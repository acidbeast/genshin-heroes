//
//  CharactersService.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/19/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CharactersServiceProtocol <NSObject>

- (void) getCharactersWithSuccess: (void(^)(NSArray* characters)) successCallback
                          onError: (void(^)(NSError* error)) errorCallback;

@end

@interface CharactersService : NSObject <CharactersServiceProtocol>

+ (instancetype) shared;
- (void) getCharactersWithSuccess: (void(^)(NSArray* characters)) successCallback
                          onError: (void(^)(NSError* error)) errorCallback;

@end

NS_ASSUME_NONNULL_END

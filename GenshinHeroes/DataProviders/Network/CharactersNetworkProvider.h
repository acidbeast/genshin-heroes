//
//  CharactersService.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/19/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CharactersNetworkProviderProtocol <NSObject>

- (void) getCharactersWithSuccess: (void(^)(NSDictionary* characters)) successCallback
                          onError: (void(^)(NSError* error)) errorCallback;

@end

@interface CharactersNetworkProvider : NSObject <CharactersNetworkProviderProtocol>

//+ (instancetype) shared;
- (void) getCharactersWithSuccess: (void(^)(NSDictionary* characters)) successCallback
                          onError: (void(^)(NSError* error)) errorCallback;

@end

NS_ASSUME_NONNULL_END

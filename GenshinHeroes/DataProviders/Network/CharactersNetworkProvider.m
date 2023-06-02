//
//  CharactersService.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/19/23.
//

#import "CharactersNetworkProvider.h"
#import "Character+CoreDataClass.h"

@interface CharactersNetworkProvider ()

@end

@implementation CharactersNetworkProvider

static NSString* charactersURL = @"https://api.genshin.dev/characters/all";

+ (instancetype) shared {
    static CharactersNetworkProvider* service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[CharactersNetworkProvider alloc] init];
    });
    return service;
}

- (void) getCharactersWithSuccess: (void(^)(NSDictionary* characters)) successCallback
                          onError: (void(^)(NSError* error)) errorCallback {
    NSURL* url = [NSURL URLWithString: charactersURL];
    NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration: configuration];
    NSURLSessionDataTask* task = [session dataTaskWithURL: url completionHandler: ^(NSData* data, NSURLResponse* response, NSError*  error) {
            if (error && errorCallback) {
                errorCallback(error);
                return;
            }
            if (successCallback) {
                NSError* jsonSerializationError = nil;
                NSDictionary* jsonObject = (NSDictionary*) [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingAllowFragments error: &jsonSerializationError];
                if (jsonSerializationError != nil) {
                    errorCallback(jsonSerializationError);
                    return;
                }
                successCallback(jsonObject);
            }
    }];
    [task resume];
}

@end

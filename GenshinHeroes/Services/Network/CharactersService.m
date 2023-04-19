//
//  CharactersService.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/19/23.
//

#import "CharactersService.h"

@interface CharactersService ()

@end

@implementation CharactersService

static NSString* charactersURL = @"https://api.genshin.dev/characters/all";

+ (instancetype) shared {
    static CharactersService* service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[CharactersService alloc] init];
    });
    return service;
}

- (void) getCharactersWithSuccess: (void(^)(NSArray* characters)) successCallback
                          onError: (void(^)(NSError* error)) errorCallback {
    NSLog(@"CharactersService fetchCharacters");
    NSURL* url = [NSURL URLWithString: charactersURL];
    NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration: configuration];
    NSURLSessionDataTask* task = [session dataTaskWithURL: url completionHandler: ^(NSData* data, NSURLResponse* response, NSError*  error) {
            if (error && errorCallback) {
                errorCallback(error);
                return;
            }
            if (successCallback) {
                NSLog(@"data: %@", data);
                // Convert Data To CoreData Model (Character) Array here.
                successCallback(nil);
            }
    }];
    [task resume];
}

@end

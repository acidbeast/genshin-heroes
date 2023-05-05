//
//  FavoritesVM.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/5/23.
//

#import "FavoritesVM.h"

typedef void (^FetchFavoritesErrorBlock)(NSError* error);

@interface FavoritesVM ()

@property (weak, nonatomic) CoreDataService* coreDataService;
@property (copy, nonatomic) FetchFavoritesErrorBlock fetchFavoritesErrorBlock;

@end

@implementation FavoritesVM

- (instancetype) initWithcoreDataService: (CoreDataService*) coreDataService {
    self = [super init];
    if (self) {
        __weak FavoritesVM* weakSelf = self;
        self.coreDataService = coreDataService;
        self.fetchFavoritesErrorBlock = ^(NSError* error) {
            [weakSelf.delegate onFetchFavoritesError: error];
        };
    }
    return self;
}

- (void) fetchFavorites {
    self.favorites = [self.coreDataService fetchFavorites];
    NSLog(@"fetchFavorites count: %ld", self.favorites.count);
}

@end

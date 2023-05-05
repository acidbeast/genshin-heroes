//
//  FavoritesVC.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/18/23.
//

#import "FavoritesVC.h"

@interface FavoritesVC ()

@end

@implementation FavoritesVC

- (instancetype) initWithViewModel: (FavoritesVM*) viewModel {
    self = [super init];
    if (self) {
        self.router = nil;
        self.viewModel = viewModel;
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void) viewWillAppear:(BOOL) animated {
    [super viewWillAppear: animated];
}

@end

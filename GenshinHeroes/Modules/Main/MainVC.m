//
//  MainVC.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 3/11/23.
//

#import "MainVC.h"


@interface MainVC ()

@end

@implementation MainVC

- (instancetype) initWithViewModel: (MainVM*) viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.viewModel.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.viewModel fetchCharacters];
}

#pragma mark - MainVMDelegateProtocol

- (void) onFetchCharactersLoading {
    NSLog(@"onFetchCharactersLoading");
}

- (void) onFetchCharactersSuccess {
    NSLog(@"onFetchCharactersSuccess");
}

- (void) onFetchCharactersError: (NSError*) error {
    NSLog(@"onFetchCharactersError: %@", error.localizedDescription);
}


@end

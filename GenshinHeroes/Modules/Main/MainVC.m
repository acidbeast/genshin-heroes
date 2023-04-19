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

- (instancetype)initWithViewModel: (MainVM*) viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.viewModel fetchCharacters];
}

@end

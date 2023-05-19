//
//  HeroDetailsVC.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/19/23.
//

#import "HeroDetailsVC.h"

@interface HeroDetailsVC ()

@end

@implementation HeroDetailsVC

- (instancetype) initWithViewModel: (HeroDetailsVM*) viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

@end

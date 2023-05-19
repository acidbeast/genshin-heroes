//
//  HeroDetailsVC.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/19/23.
//

#import "HeroDetailsVC.h"

@interface HeroDetailsVC ()

@property (strong, nonatomic) LoadingView* loadingView;

@end

@implementation HeroDetailsVC

- (instancetype) initWithViewModel: (HeroDetailsVM*) viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.loadingView = [[LoadingView alloc] init];
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self.viewModel getHeroDetails];
}

#pragma mark - Setup

- (void) setup {
    [self setupNavigation];
    [self setupLoadingView];
}

- (void) setupNavigation {
    [self.navigationController setNavigationBarHidden: NO];
    self.navigationItem.title = [[NSString alloc] initWithFormat: @"%@", self.viewModel.heroName];
}

- (void) setupLoadingView {
    [self.view addSubview: self.loadingView];
    self.loadingView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.loadingView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [self.loadingView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
        [self.loadingView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        [self.loadingView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor]
    ]];
}

@end

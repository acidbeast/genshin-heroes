//
//  HeroDetailsVC.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/19/23.
//

#import "HeroDetailsVC.h"

@interface HeroDetailsVC ()

@property (strong, nonatomic) LoadingView* loadingView;
@property (strong, nonatomic) BackButton* backButton;
@property (strong, nonatomic) UICollectionView* collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout* collectionLayout;

@end

@implementation HeroDetailsVC

- (instancetype) initWithViewModel: (HeroDetailsVM*) viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.viewModel.delegate = self;
        self.collectionLayout = [[UICollectionViewFlowLayout alloc] init];
        self.collectionView = [[UICollectionView alloc] initWithFrame: CGRectZero collectionViewLayout: self.collectionLayout];
        self.loadingView = [[LoadingView alloc] init];
        self.backButton = [[BackButton alloc] init];
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
    [self setupBackButton];
}

- (void) setupNavigation {
    [self.navigationController setNavigationBarHidden: YES];
    //self.navigationItem.title = [[NSString alloc] initWithFormat: @"%@", self.viewModel.heroName];
}

- (void) setupBackButton {
    [self.view addSubview: self.backButton];
    self.backButton.layer.zPosition = 2;
    [NSLayoutConstraint activateConstraints: @[
        [self.backButton.topAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.topAnchor constant: 16],
        [self.backButton.leadingAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.leadingAnchor constant: 16]
    ]];
    UIAction* buttonAction = [UIAction actionWithHandler: ^(UIAction* action) {
        [self.router back];
    }];
    [self.backButton addAction:buttonAction forControlEvents: UIControlEventTouchUpInside];
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

- (void) setupCollectionView {
    
}

@end

//
//  MainVC.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 3/11/23.
//

#import "MainVC.h"


@interface MainVC ()

@property (strong, nonatomic) LoadingView* loadingView;

@end

@implementation MainVC

- (instancetype) initWithViewModel: (MainVM*) viewModel {
    self = [super init];
    if (self) {
        self.router = nil;
        self.viewModel = viewModel;
        self.viewModel.delegate = self;
        self.loadingView = [[LoadingView alloc] initWithFrame: CGRectZero];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self.viewModel fetchCharacters];
}

#pragma mark - Setup

- (void) setup {
    [self setupNavigation];
    [self setupLoadingView];
    [self registerCells];
}

- (void) setupNavigation {
    [self.navigationController setNavigationBarHidden: YES];
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

#pragma mark - MainVMDelegateProtocol

- (void) onFetchCharactersLoading {
    NSLog(@"onFetchCharactersLoading");
}

- (void) onFetchCharactersSuccess {
    NSLog(@"onFetchCharactersSuccess");
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.loadingView removeFromSuperview];
        // TODO: check amount of characters, if 0 show empty screen.
        [self setupCollectionView];
        [self.router showTabBar];
    });
}

- (void) onFetchCharactersError: (NSError*) error {
    NSLog(@"onFetchCharactersError: %@", error.localizedDescription);
    [self.router showErrorWithText: @"Network Error"
                        buttonText: @"Try Again"
                       actionBlock: nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel.characters count];
//    return 3;
}

#pragma mark - UICollectionViewDelegate

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TwoColumnCollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier: self.cellId forIndexPath: indexPath];
    if (!cell) {
        cell = [[TwoColumnCollectionViewCell alloc] init];
    }
    Character* character = [self.viewModel.characters objectAtIndex: indexPath.row];
    [cell updateWithCharacter: character];
    return cell;
}

@end

//
//  FavoritesVC.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/18/23.
//

#import "FavoritesVC.h"

@interface FavoritesVC ()

@property (strong, nonatomic) LoadingView* loadingView;
@property (strong, nonatomic) EmptyView* emptyView;

@end

@implementation FavoritesVC

- (instancetype) initWithViewModel: (FavoritesVM*) viewModel {
    self = [super init];
    if (self) {
        self.router = nil;
        self.viewModel = viewModel;
        self.viewModel.delegate = self;
        self.loadingView = [[LoadingView alloc] initWithFrame: CGRectZero];
        self.emptyView = [[EmptyView alloc] initWithText: @"Favorites collection\nis empty"];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void) viewWillAppear:(BOOL) animated {
    [super viewWillAppear: animated];
    [self.viewModel fetchFavorites];
    [self.collectionView reloadData];
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

- (void) setupEmptyView {
    [self.view addSubview: self.emptyView];
    self.emptyView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.emptyView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [self.emptyView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
        [self.emptyView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        [self.emptyView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor]
    ]];
}

#pragma mark - FavoritesVMDelegateProtocol

- (void) onFetchFavoritesLoading {
    [self.collectionView removeFromSuperview];
    [self setupLoadingView];
}

- (void) onFetchFavoritesSuccess {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.loadingView removeFromSuperview];
        if ([self.viewModel.favorites count] == 0) {
            [self setupEmptyView];
        } else {
            [self setupCollectionView];
        }
    });
}

- (void) onFetchFavoritesError: (NSError*) error {
    [self.router showErrorWithText: @"Network Error"
                        buttonText: @"Try Again"
                       actionBlock: nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel.favorites count];
}

#pragma mark - UICollectionViewDelegate

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TwoColumnCollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier: self.cellId forIndexPath: indexPath];
    if (!cell) {
        cell = [[TwoColumnCollectionViewCell alloc] init];
    }
    Character* character = [self.viewModel.favorites objectAtIndex: indexPath.row];
    __weak FavoritesVC* weakSelf = self;
    cell.favoriteActionBlock = ^(BOOL value) {
        [weakSelf.viewModel saveCharacter: character
                        withFavoriteValue: false
                                onSuccess: ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.viewModel fetchFavorites];
                [self.collectionView reloadData];
            });
        }
                                  onError:^(NSError *error) {
        // TODO: Show error notification with error over content
        }
        ];
    };
    [cell updateWithCharacter: character];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Character* character = [self.viewModel.favorites objectAtIndex: indexPath.row];
    [self.router showHeroDetailsWithName: character.name];
    [self.router hideTabBar];
}

@end

//
//  HeroDetailsVC.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/19/23.
//

#import "DetailsVC.h"

@interface DetailsVC ()

@property (strong, nonatomic) LoadingView* loadingView;
@property (strong, nonatomic) FavoriteButton* favoriteButton;
@property (strong, nonatomic) BackButton* backButton;
@property (strong, nonatomic) UICollectionView* collectionView;

@end

@implementation DetailsVC

- (instancetype) initWithViewModel: (DetailsVM*) viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.viewModel.delegate = self;
        UICollectionViewCompositionalLayout* layout = [self setupCompositionalLayout];
        self.collectionView = [[UICollectionView alloc] initWithFrame: CGRectZero collectionViewLayout: layout];
        self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.loadingView = [[LoadingView alloc] init];
        self.backButton = [[BackButton alloc] init];
        self.favoriteButton = [[FavoriteButton alloc] init];
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
    [self setupView];
    [self registerCells];
//    [self setupLoadingView];
    [self setupBackButton];
    [self setupFavoriteButton];
    [self setupCollectionView];
    [self bringButtonsToFront];
}


- (void) setupNavigation {
    [self.navigationController setNavigationBarHidden: YES];
}

- (void) setupView {
    self.view.backgroundColor = Colors.shared.background[@"white"];
}

- (void) setupBackButton {
    [self.view addSubview: self.backButton];
    [NSLayoutConstraint activateConstraints: @[
        [self.backButton.topAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.topAnchor constant: 16],
        [self.backButton.leadingAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.leadingAnchor constant: 16]
    ]];
    UIAction* buttonAction = [UIAction actionWithHandler: ^(UIAction* action) {
        [self.router back];
    }];
    [self.backButton addAction:buttonAction forControlEvents: UIControlEventTouchUpInside];
}

- (void) setupFavoriteButton {
    [self.view addSubview: self.favoriteButton];
    self.favoriteButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.favoriteButton.topAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.topAnchor constant: 16],
        [self.favoriteButton.trailingAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.trailingAnchor constant: -16]
    ]];
    UIAction* buttonAction = [UIAction actionWithHandler: ^(__kindof UIAction * _Nonnull action) {
        NSLog(@"123456");
    }];
    [self.favoriteButton addAction:buttonAction forControlEvents: UIControlEventTouchUpInside];
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

- (UICollectionViewCompositionalLayout*) setupCompositionalLayout {
    UICollectionViewCompositionalLayoutConfiguration* configuration = [[UICollectionViewCompositionalLayoutConfiguration alloc] init];
    configuration.interSectionSpacing = 16;
    configuration.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionLayoutListConfiguration* config = [[UICollectionLayoutListConfiguration alloc] initWithAppearance: UICollectionLayoutListAppearancePlain];
    config.showsSeparators = NO;
    UICollectionViewCompositionalLayout* layout = [UICollectionViewCompositionalLayout layoutWithListConfiguration: config];
    [layout setConfiguration: configuration];
    return layout;
}

- (void) setupCollectionView {
    [self.view addSubview: self.collectionView];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.collectionView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [self.collectionView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
        [self.collectionView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant: 16],
        [self.collectionView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant: -16]
    ]];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

- (void) bringButtonsToFront {
    [self.view bringSubviewToFront: self.backButton];
    [self.view bringSubviewToFront: self.favoriteButton];
}

#pragma mark - Register Cells

- (void) registerCells {
    [self registerCellWith: [UICollectionViewCell class]];
    [self registerCellWith: [DetailsImageCollectionViewCell class]];
    [self registerCellWith: [DetailsTitleCollectionViewCell class]];
    [self registerCellWith: [DetailsRatingCollectionViewCell class]];
    [self registerCellWith: [DetailsTextCollectionViewCell class]];
}

- (void) registerCellWith: (Class) cellClass {
    [self.collectionView registerClass: cellClass forCellWithReuseIdentifier: [cellClass identifier]];
}

#pragma mark - HeroDetailsVMDelegate

- (void) onFetchHeroLoading {}

- (void) onFetchHeroSuccess {}

- (void) onFetchHeroError: (NSError*) error {
    
}

#pragma mark - Create Cells

- (UICollectionViewCell*) createImageCellWith: (NSIndexPath*) indexPath section: (DetailsSection*) section {
    DetailsImageCollectionViewCell* cell = [self createCellWith: [DetailsImageCollectionViewCell class] indexPath: indexPath];
    [cell updateWithSection: section];
    return cell;
}

- (UICollectionViewCell*) createTitleCellWith: (NSIndexPath*) indexPath section: (DetailsSection*) section {
    DetailsTitleCollectionViewCell* cell = [self createCellWith: [DetailsTitleCollectionViewCell class] indexPath: indexPath];
    [cell updateWithSection: section];
    return cell;
}

- (UICollectionViewCell*) createRatingCellWith: (NSIndexPath*) indexPath section: (DetailsSection*) section {
    DetailsRatingCollectionViewCell* cell = [self createCellWith: [DetailsRatingCollectionViewCell class] indexPath: indexPath];
    [cell updateWithSection: section];
    return cell;
}

- (UICollectionViewCell*) createTextCellWith: (NSIndexPath*) indexPath section: (DetailsSection*) section {
    DetailsTextCollectionViewCell* cell = [self createCellWith: [DetailsTextCollectionViewCell class] indexPath: indexPath];
    [cell updateWithSection: section];
    return cell;
}

- (id) createCellWith: (Class) class indexPath: (NSIndexPath*) indexPath {
    id cell = [self.collectionView dequeueReusableCellWithReuseIdentifier: [class identifier] forIndexPath: indexPath];
    if (!cell) {
        cell = [class new];
    }
    return cell;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel.sections count];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell* cell = nil;
    DetailsSection* section = self.viewModel.sections[indexPath.row];
    switch (section.type) {
        case DetailsSectionTypeImage:
            cell = [self createImageCellWith: indexPath section: section];
            break;
            
        case DetailsSectionTypeTitle:
            cell = [self createTitleCellWith: indexPath section: section];
            break;
            
        case DetailsSectionTypeRating:
            cell = [self createRatingCellWith: indexPath section: section];
            break;
            
        case DetailsSectionTypeText:
            cell = [self createTextCellWith: indexPath section: section];
            break;
            
        default:
            cell = [self.collectionView dequeueReusableCellWithReuseIdentifier: [UICollectionViewCell identifier] forIndexPath: indexPath];
            if (!cell) {
                cell = [[UICollectionViewCell alloc] init];
            }
            break;
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailsSection* section = self.viewModel.sections[indexPath.row];
    CGFloat side = (CGRectGetWidth(self.view.frame)) - 32;
    CGSize size = CGSizeZero;
    switch (section.type) {
        case DetailsSectionTypeImage:
            size = CGSizeMake(side, side);
            break;

        default:
            size = CGSizeMake(side, 0);
            break;
    }
    return size;
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger) sectionIndex {
    return UIEdgeInsetsMake(16, 16, 16, 16);
}

//- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 16;
//}

@end

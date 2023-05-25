//
//  HeroDetailsVC.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/19/23.
//

#import "DetailsVC.h"

@interface DetailsVC ()

@property (strong, nonatomic) LoadingView* loadingView;
@property (strong, nonatomic) BackButton* backButton;
@property (strong, nonatomic) UICollectionView* collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout* collectionLayout;

@end

@implementation DetailsVC

- (instancetype) initWithViewModel: (DetailsVM*) viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.viewModel.delegate = self;
        self.collectionLayout = [[UICollectionViewFlowLayout alloc] init];
        [self.collectionLayout setScrollDirection: UICollectionViewScrollDirectionVertical];
        self.collectionView = [[UICollectionView alloc] initWithFrame: CGRectZero collectionViewLayout: self.collectionLayout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
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
    [self registerCells];
//    [self setupLoadingView];
    [self setupCollectionView];
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
    [self.view addSubview: self.collectionView];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.collectionView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [self.collectionView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
        [self.collectionView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        [self.collectionView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor]
    ]];
}

#pragma mark - Register Cells

- (void) registerCells {
    [self registerCellWith: [UICollectionViewCell class]];
    [self registerCellWith: [DetailsImageCollectionViewCell class]];
    [self registerCellWith: [DetailsTitleCollectionViewCell class]];
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
    CGFloat width = (CGRectGetWidth(self.view.frame));
    return CGSizeMake(width - 32, 100);
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(16, 16, 16, 16);
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 16;
}

@end

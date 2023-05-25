//
//  TwoColumnCharactersCollectionVC.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/28/23.
//

#import "TwoColumnCollectionVC.h"

@interface TwoColumnCollectionVC ()

@property (strong, nonatomic) UICollectionViewFlowLayout* collectionFlowLayout;

@end

@implementation TwoColumnCollectionVC

- (instancetype) init {
    self = [super init];
    if (self) {
        self.collectionFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        [self.collectionFlowLayout setScrollDirection: UICollectionViewScrollDirectionVertical];
        self.collectionView = [[UICollectionView alloc] initWithFrame: CGRectZero collectionViewLayout: self.collectionFlowLayout];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Setup

- (void) setupCollectionView {
    [self.view addSubview: self.collectionView];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.backgroundColor = [UIColor colorWithHex: @"#ebeaef"];
    [NSLayoutConstraint activateConstraints: @[
        [self.collectionView.topAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.topAnchor],
        [self.collectionView.bottomAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.bottomAnchor],
        [self.collectionView.leadingAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.collectionView.trailingAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.trailingAnchor]
    ]];
}

#pragma mark - Register Cells

- (void) registerCells {
    [self.collectionView registerClass: [TwoColumnCollectionViewCell class] forCellWithReuseIdentifier: [TwoColumnCollectionViewCell identifier]];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (CGRectGetWidth(self.view.frame) - 3 * 16) / 2;
    return CGSizeMake(width, width + 68);
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(16, 16, 16, 16);
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 16;
}

@end

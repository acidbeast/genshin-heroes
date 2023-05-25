//
//  TwoColumnCharactersCollectionVC.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/28/23.
//

#import <UIKit/UIKit.h>
#import "UIColor+Hex.h"
#import "TwoColumnCollectionViewCell.h"
#import "UICollectionViewCell+Identifier.h"

NS_ASSUME_NONNULL_BEGIN

@interface TwoColumnCollectionVC : UIViewController <UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView* collectionView;

- (void) setupCollectionView;
- (void) registerCells;

@end

NS_ASSUME_NONNULL_END

//
//  DetailsImageCollectionViewCell.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/24/23.
//

#import <UIKit/UIKit.h>
#import "DetailsSection.h"
#import "UIColor+Hex.h"
#import "Blocks.h"
#import "BackButton.h"
#import "FavoriteButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsImageCollectionViewCell : UICollectionViewCell

- (void) updateWithSection: (DetailsSection*) section;
- (void) updateWithBackAction: (EmptyBlock) backAction favoriteAction: (EmptyBlock) favoriteAction;
- (void) toggleFavorite: (BOOL) value;

@end

NS_ASSUME_NONNULL_END

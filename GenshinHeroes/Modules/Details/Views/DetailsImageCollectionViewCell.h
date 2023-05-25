//
//  DetailsImageCollectionViewCell.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/24/23.
//

#import <UIKit/UIKit.h>
#import "DetailsSection.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsImageCollectionViewCell : UICollectionViewCell

- (void) updateWithSection: (DetailsSection*) section;

@end

NS_ASSUME_NONNULL_END

//
//  DetailsTwoColumnCollectionViewCell.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/1/23.
//

#import <UIKit/UIKit.h>
#import "DetailsSection.h"
#import "Colors.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsTwoColumnCollectionViewCell : UICollectionViewCell

- (void) updateWithSection: (DetailsSection*) section;

@end

NS_ASSUME_NONNULL_END

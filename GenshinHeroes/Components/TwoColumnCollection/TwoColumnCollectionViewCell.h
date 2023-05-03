//
//  TwoColumnCollectionViewCell.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/28/23.
//

#import <UIKit/UIKit.h>
#import "Character+CoreDataClass.h"
#import "Vision+CoreDataClass.h"
#import "Weapon+CoreDataClass.h"
#import "Favorite+CoreDataClass.h"
#import "Colors.h"
#import "UIColor+Hex.h"
#import "FavoriteButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface TwoColumnCollectionViewCell : UICollectionViewCell

- (void) updateWithCharacter: (Character*) character;

@end

NS_ASSUME_NONNULL_END

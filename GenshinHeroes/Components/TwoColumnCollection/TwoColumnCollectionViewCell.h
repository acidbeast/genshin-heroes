//
//  TwoColumnCollectionViewCell.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/28/23.
//

#import <UIKit/UIKit.h>
#import "Character+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface TwoColumnCollectionViewCell : UICollectionViewCell

- (void) updateWithCharacter: (Character*) character;

@end

NS_ASSUME_NONNULL_END
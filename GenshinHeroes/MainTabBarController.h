//
//  MainTabBarController.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/17/23.
//

#import <UIKit/UIKit.h>
#import "UIColor+Hex.h"
#import "Blocks.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainTabBarController : UITabBarController

- (void) hideTabBarWithAnimation;
- (void) showTabBarWithAnimation;

@end

NS_ASSUME_NONNULL_END

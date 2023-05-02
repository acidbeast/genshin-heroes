//
//  Colors.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/2/23.
//

#import <UIKit/UIKit.h>
#import "UIColor+Hex.h"

NS_ASSUME_NONNULL_BEGIN

@interface Colors : NSObject

+ (instancetype) shared;

@property (strong, nonatomic) NSDictionary<NSString*, UIColor*>* background;
@property (strong, nonatomic) NSDictionary<NSString*, UIColor*>* text;
@property (strong, nonatomic) NSDictionary<NSString*, UIColor*>* vision;
@property (strong, nonatomic) NSDictionary<NSString*, UIColor*>* rarity;

@end

NS_ASSUME_NONNULL_END

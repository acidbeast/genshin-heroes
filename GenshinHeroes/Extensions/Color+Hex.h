//
//  Color+Hex.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/25/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor(Hex)

+ (UIColor *) colorWithHex: (NSString*) hexString;

@end

NS_ASSUME_NONNULL_END

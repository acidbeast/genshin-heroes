//
//  CollectionViewCell+Identifier.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/24/23.
//

#import "UICollectionViewCell+Identifier.h"

@implementation UICollectionViewCell(Identifier)

+ (NSString*) identifier {
    return NSStringFromClass([self class]);
}

@end

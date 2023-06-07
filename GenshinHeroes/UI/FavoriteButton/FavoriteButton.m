//
//  FavoriteButton.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/3/23.
//

#import "FavoriteButton.h"

@implementation FavoriteButton

- (instancetype) initWithFrame:(CGRect) frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (UIView*) hitTest: (CGPoint) point withEvent: (UIEvent*) event {
    int extensionValue = 8;
    CGRect extendedFrame = CGRectMake(0 - extensionValue, 0 - extensionValue, self.bounds.size.width + (extensionValue * 2), self.bounds.size.height + (extensionValue * 2));
    return CGRectContainsPoint(extendedFrame, point) == 1 ? self : nil;
}

- (void) setup {
    self.frame = CGRectMake(0, 0, 24, 24);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 12;
    self.layer.borderWidth = 0;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 8.f;
    self.layer.shadowOpacity = 0.1f;
    self.layer.masksToBounds = NO;
    [self setImage: [UIImage systemImageNamed: @"heart"] forState: UIControlStateNormal];
    self.tintColor = Colors.shared.favorite[@"primary"];
    self.imageEdgeInsets = UIEdgeInsetsMake(5, 3, 4, 3);
}

- (void) toggleSelected: (BOOL) value {
    NSString* iconName = [NSString stringWithFormat: @"%@", value == YES ? @"heart.fill" : @"heart"];
    NSString* colorName = [NSString stringWithFormat: @"%@", value == YES ? @"selected" : @"primary"];
    [self setImage: [UIImage systemImageNamed: iconName] forState: UIControlStateNormal];
    self.tintColor = Colors.shared.favorite[colorName];
}

@end

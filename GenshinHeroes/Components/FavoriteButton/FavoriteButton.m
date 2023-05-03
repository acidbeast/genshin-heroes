//
//  FavoriteButton.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/3/23.
//

#import "FavoriteButton.h"

@implementation FavoriteButton

- (instancetype) init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (UIView*) hitTest: (CGPoint) point withEvent: (UIEvent*) event {
    int extesionValue = 8;
    CGRect extendedFrame = CGRectMake(0 - extesionValue, 0 - extesionValue, self.bounds.size.width + (extesionValue * 2), self.bounds.size.height + (extesionValue * 2));
    return CGRectContainsPoint(extendedFrame, point) == 1 ? self : nil;
}

#pragma mark - Setup

- (void) setup {
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
    self.imageEdgeInsets = UIEdgeInsetsMake(2, 1, 0, 1);
}

@end

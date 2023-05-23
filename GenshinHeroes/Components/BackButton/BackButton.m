//
//  BackButton.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/23/23.
//

#import "BackButton.h"

@implementation BackButton

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (UIView*) hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    int extensionValue = 8;
    CGRect extendedFrame = CGRectMake(0 - extensionValue, 0 - extensionValue, self.bounds.size.width, self.bounds.size.height);
    return CGRectContainsPoint(extendedFrame, point) == 1 ? self : nil;
}

#pragma mark - Setup

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
    [self setImage: [UIImage systemImageNamed: @"chevron.backward"] forState: UIControlStateNormal];
    self.tintColor = Colors.shared.favorite[@"primary"];
    self.imageEdgeInsets = UIEdgeInsetsMake(5, 3, 4, 3);
}


@end

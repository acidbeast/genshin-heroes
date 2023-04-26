//
//  IndicatorView.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/25/23.
//

#import "IndicatorView.h"

@interface IndicatorView()
    
@property (strong, nonatomic) UIImageView* iconView;
    
@end

@implementation IndicatorView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        self.iconView = [[UIImageView alloc] init];
        [self setup];
    }
    return self;
}

- (void) setup {
    [self setupConstraints];
    [self setupIcon];
}

- (void) setupConstraints {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.widthAnchor constraintEqualToConstant: 128],
        [self.heightAnchor constraintEqualToConstant: 32]
    ]];
}

- (void) setupIcon {
    [self addSubview: self.iconView];
    self.iconView.image = [UIImage imageNamed: [self nextIconName]];
    self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
    self.iconView.tintColor = [UIColor blackColor];
    [NSLayoutConstraint activateConstraints: @[
        [self.iconView.widthAnchor constraintEqualToConstant: 32],
        [self.iconView.heightAnchor constraintEqualToConstant: 32],
        [self.iconView.centerXAnchor constraintEqualToAnchor: self.centerXAnchor]
    ]];
}

- (NSString*) nextIconName {
    NSArray* names = @[@"anemo", @"cryo", @"dendro", @"electro", @"geo", @"hydro", @"pyro"];
    NSInteger index = (int)arc4random_uniform(700) / 100;
    return names[index];
}

@end

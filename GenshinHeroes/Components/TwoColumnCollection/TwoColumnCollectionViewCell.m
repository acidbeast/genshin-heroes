//
//  TwoColumnCollectionViewCell.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/28/23.
//

#import "TwoColumnCollectionViewCell.h"

@interface TwoColumnCollectionViewCell ()

@property (strong, nonatomic) UILabel* titleLabel;

@end

@implementation TwoColumnCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        [self setup];
    }
    return self;
}

#pragma mark - Setup

- (void) setup {
    [self setupStyle];
    [self setupTitleLabel];
}

- (void) setupStyle {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 16;
}

- (void) setupTitleLabel {
    [self addSubview: self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.textColor = [UIColor blackColor];
    [NSLayoutConstraint activateConstraints: @[
        [self.titleLabel.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant: 16],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant: 16]
    ]];
}

- (void) updateWithCharacter: (Character*) character {
    self.titleLabel.text = character.name;
}

@end

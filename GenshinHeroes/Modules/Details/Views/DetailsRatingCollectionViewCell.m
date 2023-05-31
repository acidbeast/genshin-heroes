//
//  DetailsRatingCollectionViewCell.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/26/23.
//

#import "DetailsRatingCollectionViewCell.h"

@interface DetailsRatingCollectionViewCell ()

@property (strong, nonatomic) UIStackView* stack;

@end


@implementation DetailsRatingCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self initValues];
        [self setup];
    }
    return self;
}

#pragma mark - Init values

- (void) initValues {
    self.stack = [[UIStackView alloc] init];
}

#pragma mark - Prepare For Reuse

- (void) prepareForReuse {
    [super prepareForReuse];
}

#pragma mark - Setup

- (void) setup {
    [self setupStarsStack];
}

- (void) setupStarsStack {
    [self addSubview: self.stack];
    self.stack.translatesAutoresizingMaskIntoConstraints = NO;
    self.stack.axis = UILayoutConstraintAxisHorizontal;
    self.stack.distribution = UIStackViewDistributionFill;
    self.stack.alignment = UIStackViewAlignmentLeading;
    [NSLayoutConstraint activateConstraints: @[
        [self.stack.heightAnchor constraintEqualToConstant: 32],
        [self.stack.topAnchor constraintEqualToAnchor: self.topAnchor],
        [self.stack.leadingAnchor constraintEqualToAnchor: self.leadingAnchor]
    ]];
}

#pragma mark - Cell Attributes


#pragma mark - Update with section

- (void) updateWithSection: (DetailsSection*) section {
    for (int i = 0; i < section.rating; i++ ) {
        [self addStarsToStackWithRarity: section.rating];
    }
}

#pragma mark - Methods

- (void) addStarsToStackWithRarity: (NSInteger) rarity {
    UIImageView* starImageView = [[UIImageView alloc] initWithImage: [UIImage systemImageNamed: @"star.fill"]];
    starImageView.translatesAutoresizingMaskIntoConstraints = NO;
    starImageView.tintColor = Colors.shared.rarity[[NSString stringWithFormat: @"rarity%ld", rarity]];
    [NSLayoutConstraint activateConstraints: @[
        [starImageView.widthAnchor constraintEqualToConstant: 32],
        [starImageView.heightAnchor constraintEqualToConstant: 32]
    ]];
    [self.stack addArrangedSubview: starImageView];
}

@end

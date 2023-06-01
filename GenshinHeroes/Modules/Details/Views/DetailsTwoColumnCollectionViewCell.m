//
//  DetailsTwoColumnCollectionViewCell.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/1/23.
//

#import "DetailsTwoColumnCollectionViewCell.h"

@interface  DetailsTwoColumnCollectionViewCell ()

@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UILabel* valueLabel;

@end


@implementation DetailsTwoColumnCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self initValues];
        [self setup];
    }
    return self;
}

#pragma mark - Setup

- (void) initValues {
    self.titleLabel = [[UILabel alloc] init];
    self.valueLabel = [[UILabel alloc] init];
}

- (void) setup {
    [self setupTitleLabel];
    [self setupValueLabel];
}

- (void) setupTitleLabel {
    [self addSubview: self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.titleLabel.topAnchor constraintEqualToAnchor: self.topAnchor constant: 16],
        [self.titleLabel.bottomAnchor constraintEqualToAnchor: self.bottomAnchor constant: -16],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor: self.leadingAnchor]
    ]];
}

- (void) setupValueLabel {
    [self addSubview: self.valueLabel];
    self.valueLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.valueLabel.topAnchor constraintEqualToAnchor: self.topAnchor constant: 16],
        [self.valueLabel.bottomAnchor constraintEqualToAnchor: self.bottomAnchor constant: -16],
        [self.valueLabel.trailingAnchor constraintEqualToAnchor: self.trailingAnchor]
    ]];
}

#pragma mark - Update with section

- (void) updateWithSection: (DetailsSection*) section  {
    self.titleLabel.text = section.text;
    self.valueLabel.text = section.text;
}


@end

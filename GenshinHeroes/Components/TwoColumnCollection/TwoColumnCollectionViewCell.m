//
//  TwoColumnCollectionViewCell.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/28/23.
//

#import "TwoColumnCollectionViewCell.h"

@interface TwoColumnCollectionViewCell ()

@property (strong, nonatomic) UIView* imagePlacehodler;
@property (strong, nonatomic) UILabel* titleLabel;


@end

@implementation TwoColumnCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        self.imagePlacehodler = [[UIView alloc] init];
        self.titleLabel = [[UILabel alloc] init];
        [self setup];
    }
    return self;
}

#pragma mark - Setup

- (void) setup {
    [self setupStyle];
    [self setupImagePlacehodler];
    [self setupTitleLabel];
}

- (void) setupStyle {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 16;
    self.layer.borderWidth = 0;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 8.f;
    self.layer.shadowOpacity = 0.1f;
    self.layer.masksToBounds = NO;
}

- (void) setupImagePlacehodler {
    [self addSubview: self.imagePlacehodler];
    self.imagePlacehodler.translatesAutoresizingMaskIntoConstraints = NO;
    self.imagePlacehodler.backgroundColor = [UIColor colorWithHex: @"#efefef"];
    self.imagePlacehodler.layer.cornerRadius = 16;
    [NSLayoutConstraint activateConstraints: @[
        [self.imagePlacehodler.topAnchor constraintEqualToAnchor: self.topAnchor constant: 16],
        [self.imagePlacehodler.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant: 16],
        [self.imagePlacehodler.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant: -16],
        [self.imagePlacehodler.heightAnchor constraintEqualToAnchor: self.imagePlacehodler.widthAnchor]
    ]];
}

- (void) setupTitleLabel {
    [self addSubview: self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.font = [UIFont fontWithName: @"Avenir Next Regular" size: 14.0];
    [NSLayoutConstraint activateConstraints: @[
        [self.titleLabel.topAnchor constraintEqualToAnchor: self.imagePlacehodler.bottomAnchor constant: 16],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant: 16],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant: -16]
    ]];
}

#pragma mark - Methods

- (void) updateWithCharacter: (Character*) character {
    self.titleLabel.text = character.name;
}

@end

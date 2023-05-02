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
@property (strong, nonatomic) UIView* iconsPlaceholder;
@property (strong, nonatomic) UIImageView* iconRarity;
@property (strong, nonatomic) UIImageView* iconVision;

@end

@implementation TwoColumnCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        self.imagePlacehodler = [[UIView alloc] init];
        self.titleLabel = [[UILabel alloc] init];
        self.iconsPlaceholder = [[UIView alloc] init];
        self.iconRarity = [[UIImageView alloc] init];
        self.iconVision = [[UIImageView alloc] init];
        [self setup];
    }
    return self;
}

#pragma mark - Setup

- (void) setup {
    [self setupStyle];
    [self setupImagePlacehodler];
    [self setupTitleLabel];
    [self setupIconsPlaceholder];
    [self setupIconRatingIcon];
    [self setupIconElementialIcon];
    //[self setupIconWeaponIcon];
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
    self.titleLabel.numberOfLines = 1;
    [NSLayoutConstraint activateConstraints: @[
        [self.titleLabel.topAnchor constraintEqualToAnchor: self.imagePlacehodler.bottomAnchor constant: 16],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant: 16],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant: -16]
    ]];
}

- (void) setupIconsPlaceholder {
    [self addSubview: self.iconsPlaceholder];
    self.iconsPlaceholder.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.iconsPlaceholder.topAnchor constraintEqualToAnchor: self.titleLabel.bottomAnchor constant: 8],
        [self.iconsPlaceholder.heightAnchor constraintEqualToConstant: 24],
        [self.iconsPlaceholder.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant: 16],
        [self.iconsPlaceholder.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant: -16],
    ]];
}

- (void) setupIconRatingIcon {
    [self.iconsPlaceholder addSubview: self.iconRarity];
    self.iconRarity.translatesAutoresizingMaskIntoConstraints = NO;
    self.iconRarity.image = [UIImage systemImageNamed: @"star.fill"];
    self.iconRarity.tintColor = Colors.shared.background[@"primary"];
    [NSLayoutConstraint activateConstraints: @[
        [self.iconRarity.widthAnchor constraintEqualToConstant: 24],
        [self.iconRarity.heightAnchor constraintEqualToConstant: 24],
        [self.iconRarity.leadingAnchor constraintEqualToAnchor: self.iconsPlaceholder.leadingAnchor]
    ]];
}

- (void) setupIconElementialIcon {
    [self.iconsPlaceholder addSubview: self.iconVision];
    self.iconVision.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.iconVision.widthAnchor constraintEqualToConstant: 24],
        [self.iconVision.heightAnchor constraintEqualToConstant: 24],
        [self.iconVision.leadingAnchor constraintEqualToAnchor: self.iconRarity.trailingAnchor constant: 8]
    ]];
}

#pragma mark - Methods

- (void) updateWithCharacter: (Character*) character {
    self.titleLabel.text = character.name;
    [self setRarityIconColorWithValue: character.rarity];
    [self setVisionIconColorWithValue: character.vision];
}

- (void) setRarityIconColorWithValue: (NSInteger) rarity {
    if (rarity) {
        NSString* rarityColor = [[NSString alloc] initWithFormat: @"rarity%ld", (long)rarity];
        self.iconRarity.tintColor = Colors.shared.rarity[rarityColor];
    }
}

- (void) setVisionIconColorWithValue: (Vision*) vision {
    NSString* visionName = [vision.name lowercaseString];
    self.iconVision.image = [UIImage imageNamed: visionName];
    self.iconVision.tintColor = Colors.shared.vision[visionName];
}

@end

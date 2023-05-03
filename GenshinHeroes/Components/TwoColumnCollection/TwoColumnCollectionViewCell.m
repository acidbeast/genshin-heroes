//
//  TwoColumnCollectionViewCell.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/28/23.
//

#import "TwoColumnCollectionViewCell.h"

@interface TwoColumnCollectionViewCell ()

@property (strong, nonatomic) UIView* imagePlacehodlerView;
@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UIView* iconsPlaceholderView;
@property (strong, nonatomic) UIImageView* rarityIconImageView;
@property (strong, nonatomic) UIImageView* visionIconImageView;
@property (strong, nonatomic) UIImageView* weaponIconImageView;

@end

@implementation TwoColumnCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        self.imagePlacehodlerView = [[UIView alloc] init];
        self.titleLabel = [[UILabel alloc] init];
        self.iconsPlaceholderView = [[UIView alloc] init];
        self.rarityIconImageView = [[UIImageView alloc] init];
        self.visionIconImageView = [[UIImageView alloc] init];
        self.weaponIconImageView = [[UIImageView alloc] init];
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
    [self setupRatingIcon];
    [self setupElementialIcon];
    [self setupWeaponIcon];
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
    [self addSubview: self.imagePlacehodlerView];
    self.imagePlacehodlerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imagePlacehodlerView.backgroundColor = [UIColor colorWithHex: @"#efefef"];
    self.imagePlacehodlerView.layer.cornerRadius = 16;
    [NSLayoutConstraint activateConstraints: @[
        [self.imagePlacehodlerView.topAnchor constraintEqualToAnchor: self.topAnchor constant: 16],
        [self.imagePlacehodlerView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant: 16],
        [self.imagePlacehodlerView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant: -16],
        [self.imagePlacehodlerView.heightAnchor constraintEqualToAnchor: self.imagePlacehodlerView.widthAnchor]
    ]];
}

- (void) setupTitleLabel {
    [self addSubview: self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.font = [UIFont fontWithName: @"Avenir Next Regular" size: 14.0];
    self.titleLabel.numberOfLines = 1;
    [NSLayoutConstraint activateConstraints: @[
        [self.titleLabel.topAnchor constraintEqualToAnchor: self.imagePlacehodlerView.bottomAnchor constant: 16],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant: 16],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant: -16]
    ]];
}

- (void) setupIconsPlaceholder {
    [self addSubview: self.iconsPlaceholderView];
    self.iconsPlaceholderView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.iconsPlaceholderView.topAnchor constraintEqualToAnchor: self.titleLabel.bottomAnchor constant: 8],
        [self.iconsPlaceholderView.heightAnchor constraintEqualToConstant: 24],
        [self.iconsPlaceholderView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant: 16],
        [self.iconsPlaceholderView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant: -16],
    ]];
}

- (void) setupRatingIcon {
    [self.iconsPlaceholderView addSubview: self.rarityIconImageView];
    self.rarityIconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.rarityIconImageView.image = [UIImage systemImageNamed: @"star.fill"];
    self.rarityIconImageView.tintColor = Colors.shared.background[@"primary"];
    [NSLayoutConstraint activateConstraints: @[
        [self.rarityIconImageView.widthAnchor constraintEqualToConstant: 24],
        [self.rarityIconImageView.heightAnchor constraintEqualToConstant: 24],
        [self.rarityIconImageView.leadingAnchor constraintEqualToAnchor: self.iconsPlaceholderView.leadingAnchor]
    ]];
}

- (void) setupElementialIcon {
    [self.iconsPlaceholderView addSubview: self.visionIconImageView];
    self.visionIconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.visionIconImageView.widthAnchor constraintEqualToConstant: 24],
        [self.visionIconImageView.heightAnchor constraintEqualToConstant: 24],
        [self.visionIconImageView.leadingAnchor constraintEqualToAnchor: self.rarityIconImageView.trailingAnchor constant: 8]
    ]];
}

- (void) setupWeaponIcon {
    [self.iconsPlaceholderView addSubview: self.weaponIconImageView];
    self.weaponIconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.weaponIconImageView.widthAnchor constraintEqualToConstant: 24],
        [self.weaponIconImageView.heightAnchor constraintEqualToConstant: 24],
        [self.weaponIconImageView.leadingAnchor constraintEqualToAnchor: self.visionIconImageView.trailingAnchor constant: 8]
    ]];
}

#pragma mark - Methods

- (void) updateWithCharacter: (Character*) character {
    self.titleLabel.text = character.name;
    [self setRarityIconColorWithValue: character.rarity];
    [self setVisionIconColorWithValue: character.vision];
    [self setWeaponIconColorWithValue: character.weapon];
}

- (void) setRarityIconColorWithValue: (NSInteger) rarity {
    if (rarity) {
        NSString* rarityColor = [[NSString alloc] initWithFormat: @"rarity%ld", (long)rarity];
        self.rarityIconImageView.tintColor = Colors.shared.rarity[rarityColor];
    }
}

- (void) setVisionIconColorWithValue: (Vision*) vision {
    NSString* visionName = [vision.name lowercaseString];
    self.visionIconImageView.image = [UIImage imageNamed: visionName];
    self.visionIconImageView.tintColor = Colors.shared.vision[visionName];
}

- (void) setWeaponIconColorWithValue: (Weapon*) weapon {
    NSString* weaponName = [weapon.name lowercaseString];
    self.weaponIconImageView.image = [UIImage imageNamed: weaponName];
}


@end

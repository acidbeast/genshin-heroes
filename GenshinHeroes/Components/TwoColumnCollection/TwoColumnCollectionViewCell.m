//
//  TwoColumnCollectionViewCell.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/28/23.
//

#import "TwoColumnCollectionViewCell.h"

@interface TwoColumnCollectionViewCell ()

@property (strong, nonatomic) UIView* avatarPlaceholderView;
@property (strong, nonatomic) UIImageView* avatarImageView;
@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UIView* iconsPlaceholderView;
@property (strong, nonatomic) UIImageView* rarityIconImageView;
@property (strong, nonatomic) UIImageView* visionIconImageView;
@property (strong, nonatomic) UIImageView* weaponIconImageView;
@property (strong, nonatomic) FavoriteButton* favoriteButton;
@property (assign, nonatomic) BOOL isFavorite;

@end

@implementation TwoColumnCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self initValues];
        [self setup];
    }
    return self;
}

#pragma mark - Initialize Values

- (void) initValues {
    self.avatarPlaceholderView = [[UIView alloc] init];
    self.avatarImageView = [[UIImageView alloc] init];
    self.titleLabel = [[UILabel alloc] init];
    self.iconsPlaceholderView = [[UIView alloc] init];
    self.rarityIconImageView = [[UIImageView alloc] init];
    self.visionIconImageView = [[UIImageView alloc] init];
    self.weaponIconImageView = [[UIImageView alloc] init];
    self.favoriteButton = [[FavoriteButton alloc] init];
    self.isFavorite = NO;
}

#pragma mark - Prepare For Reuse

- (void) prepareForReuse {
    [super prepareForReuse];
    self.avatarImageView.image = [UIImage imageNamed: @"placeholder"];
    self.titleLabel.text = @"";
    self.rarityIconImageView.tintColor = Colors.shared.background[@"primary"];
    self.visionIconImageView.image = nil;
    self.weaponIconImageView.image = nil;
    [self.favoriteButton setImage: [UIImage systemImageNamed: @"heart"] forState: UIControlStateNormal];
    self.favoriteButton.tintColor = Colors.shared.favorite[@"primary"];
}

#pragma mark - Setup

- (void) setup {
    [self setupStyle];
    [self setupAvatarPlaceholder];
    [self setupAvatarImage];
    [self setupTitleLabel];
    [self setupIconsPlaceholder];
    [self setupRatingIcon];
    [self setupElementialIcon];
    [self setupWeaponIcon];
    [self setupFavoriteButton];
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

- (void) setupAvatarPlaceholder {
    [self addSubview: self.avatarPlaceholderView];
    self.avatarPlaceholderView.translatesAutoresizingMaskIntoConstraints = NO;
    self.avatarPlaceholderView.backgroundColor = [UIColor colorWithHex: @"#efefef"];
    self.avatarPlaceholderView.layer.cornerRadius = 16;
    [NSLayoutConstraint activateConstraints: @[
        [self.avatarPlaceholderView.topAnchor constraintEqualToAnchor: self.topAnchor constant: 16],
        [self.avatarPlaceholderView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant: 16],
        [self.avatarPlaceholderView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant: -16],
        [self.avatarPlaceholderView.heightAnchor constraintEqualToAnchor: self.avatarPlaceholderView.widthAnchor]
    ]];
}

- (void) setupAvatarImage {
    [self.avatarPlaceholderView addSubview: self.avatarImageView];
    self.avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.avatarImageView.image = [UIImage imageNamed: @"placeholder"];
    self.avatarImageView.layer.cornerRadius = 16;
    self.avatarImageView.layer.masksToBounds = YES;
    [NSLayoutConstraint activateConstraints: @[
        [self.avatarImageView.widthAnchor constraintEqualToAnchor: self.avatarPlaceholderView.widthAnchor],
        [self.avatarImageView.heightAnchor constraintEqualToAnchor: self.avatarPlaceholderView.heightAnchor],
        [self.avatarImageView.centerXAnchor constraintEqualToAnchor: self.avatarPlaceholderView.centerXAnchor],
        [self.avatarImageView.centerYAnchor constraintEqualToAnchor: self.avatarPlaceholderView.centerYAnchor],
    ]];
}

- (void) setupTitleLabel {
    [self addSubview: self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.font = [UIFont fontWithName: @"Avenir Next Regular" size: 14.0];
    self.titleLabel.numberOfLines = 1;
    [NSLayoutConstraint activateConstraints: @[
        [self.titleLabel.topAnchor constraintEqualToAnchor: self.avatarPlaceholderView.bottomAnchor constant: 16],
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
    self.weaponIconImageView.layer.opacity = 0.5f;
    [NSLayoutConstraint activateConstraints: @[
        [self.weaponIconImageView.widthAnchor constraintEqualToConstant: 24],
        [self.weaponIconImageView.heightAnchor constraintEqualToConstant: 24],
        [self.weaponIconImageView.leadingAnchor constraintEqualToAnchor: self.visionIconImageView.trailingAnchor constant: 8]
    ]];
}

- (void) setupFavoriteButton {
    [self addSubview: self.favoriteButton];
    self.favoriteButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.favoriteButton.layer.zPosition = 1;
    [NSLayoutConstraint activateConstraints: @[
        [self.favoriteButton.topAnchor constraintEqualToAnchor: self.topAnchor constant: 8],
        [self.favoriteButton.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant: -8]
    ]];
    UIAction* buttonAction = [UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        if (self.favoriteActionBlock != nil) {
            self.favoriteActionBlock(self.isFavorite);
        }
    }];
    [self.favoriteButton addAction:buttonAction forControlEvents: UIControlEventTouchUpInside];
}

#pragma mark - Methods

- (void) updateWithCharacter: (Character*) character {
    self.titleLabel.text = character.name;
    [self setupAvatarImageWithName: character.name];
    [self setRarityIconColorWithValue: character.rarity];
    [self setVisionIconColorWithValue: character.vision];
    [self setWeaponIconColorWithValue: character.weapon];
    [self setFavoriteWith: character.favorite];
    [self toggleFavoriteButtonImageStateWithValue: self.isFavorite];
}

- (void) setupAvatarImageWithName: (NSString*) name {
    NSString* lowerCasedName = [[name stringByReplacingOccurrencesOfString: @" " withString: @"-"] lowercaseString];
    NSString* avatarName = [NSString stringWithFormat: @"%@-avatar", lowerCasedName];
    UIImage* avatarImage = [UIImage imageNamed: avatarName];
    if (avatarImage != nil) {
        self.avatarImageView.image = avatarImage;
    }
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

- (void) setFavoriteWith: (Favorite*) favorite {
    if (favorite.isFavorite) {
        self.isFavorite = favorite.isFavorite;
    } else {
        self.isFavorite = NO;
    }
}

- (void) toggleFavoriteButtonImageStateWithValue: (BOOL) value {
    NSString* iconName = [NSString stringWithFormat: @"%@", value == YES ? @"heart.fill" : @"heart"];
    NSString* colorName = [NSString stringWithFormat: @"%@", value == YES ? @"selected" : @"primary"];
    [self.favoriteButton setImage: [UIImage systemImageNamed: iconName] forState: UIControlStateNormal];
    self.favoriteButton.tintColor = Colors.shared.favorite[colorName];
}

- (void) setFavoriteWithValue: (BOOL) value {
    self.isFavorite = value;
    [self toggleFavoriteButtonImageStateWithValue: value];
}

@end

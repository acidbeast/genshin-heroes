//
//  DetailsImageCollectionViewCell.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/24/23.
//

#import "DetailsImageCollectionViewCell.h"

@interface DetailsImageCollectionViewCell ()

@property (strong, nonatomic) UIImageView* imageView;
@property (strong, nonatomic) FavoriteButton* favoriteButton;
@property (strong, nonatomic) BackButton* backButton;
@property (strong, nonatomic) EmptyBlock backAction;
@property (strong, nonatomic) EmptyBlock favoriteAction;

@end

@implementation DetailsImageCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self initValues];
        [self setup];
    }
    return self;
}

- (instancetype) initWithBackAction: (EmptyBlock) backAction favoriteAction: (EmptyBlock) favoriteAction {
    self = [super initWithFrame: CGRectZero];
    if (self) {
        [self initValues];
        [self setup];
        self.backAction = backAction;
        self.favoriteAction = favoriteAction;
    }
    return self;
}

- (void) initValues {
    self.imageView = [[UIImageView alloc] init];
    self.backButton = [[BackButton alloc] init];
    self.favoriteButton = [[FavoriteButton alloc] init];
    self.backAction = nil;
    self.favoriteAction = nil;
}


#pragma mark - Prepare For Reuse

- (void) prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = nil;
    self.backButton = nil;
    self.favoriteButton = nil;
    self.backAction = nil;
    self.favoriteAction = nil;
}

#pragma mark - Setup

- (void) setup {
    [self setupStyle];
    [self setupImageView];
    [self setupBackButton];
    [self setupFavoriteButton];
    [self bringButtonsToFront];
}

- (void) setupStyle {
    
}

- (void) setupImageView {
    CGFloat width = self.frame.size.width;
    [self addSubview: self.imageView];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.backgroundColor = [UIColor colorWithHex: @"#efefef"];
    self.imageView.image = [UIImage imageNamed: @"placeholder"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.layer.cornerRadius = 16;
    self.imageView.layer.masksToBounds = YES;
    [NSLayoutConstraint activateConstraints: @[
        [self.imageView.widthAnchor constraintEqualToConstant: width],
        [self.imageView.heightAnchor constraintEqualToConstant: width],
        [self.imageView.topAnchor constraintEqualToAnchor: self.topAnchor],
        [self.imageView.bottomAnchor constraintEqualToAnchor: self.bottomAnchor],
        [self.imageView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor],
        [self.imageView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor]
    ]];
}

- (void) setupBackButton {
    [self addSubview: self.backButton];
    [NSLayoutConstraint activateConstraints: @[
        [self.backButton.topAnchor constraintEqualToAnchor: self.topAnchor constant: 16],
        [self.backButton.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant: 16]
    ]];
    UIAction* buttonAction = [UIAction actionWithHandler: ^(UIAction* action) {
        if (self.backAction != nil) {
            self.backAction();
        }
    }];
    [self.backButton addAction:buttonAction forControlEvents: UIControlEventTouchUpInside];
}

- (void) setupFavoriteButton {
    [self addSubview: self.favoriteButton];
    self.favoriteButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.favoriteButton.topAnchor constraintEqualToAnchor: self.topAnchor constant: 16],
        [self.favoriteButton.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant: -16]
    ]];
    UIAction* buttonAction = [UIAction actionWithHandler: ^(__kindof UIAction * _Nonnull action) {
        if (self.favoriteAction != nil) {
            self.favoriteAction();
        }
    }];
    [self.favoriteButton addAction:buttonAction forControlEvents: UIControlEventTouchUpInside];
}


#pragma mark - Update cell with data

- (void) updateWithSection: (DetailsSection*) section {
    [self setupImageWithName: section.imageName];
}

- (void) setupImageWithName: (NSString*) imageName {
    UIImage* avatarImage = [UIImage imageNamed: imageName];
    if (avatarImage != nil) {
        self.imageView.image = avatarImage;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
}

- (void) updateWithBackAction: (EmptyBlock) backAction favoriteAction: (EmptyBlock) favoriteAction {
    self.backAction = backAction;
    self.favoriteAction = favoriteAction;
}

- (void) bringButtonsToFront {
    [self bringSubviewToFront: self.backButton];
    [self bringSubviewToFront: self.favoriteButton];
}

@end

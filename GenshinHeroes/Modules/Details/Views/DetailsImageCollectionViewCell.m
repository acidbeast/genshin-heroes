//
//  DetailsImageCollectionViewCell.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/24/23.
//

#import "DetailsImageCollectionViewCell.h"

@interface DetailsImageCollectionViewCell ()

@property (strong, nonatomic) UIImageView* imageView;

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

- (void) initValues {
    self.imageView = [[UIImageView alloc] init];
}


#pragma mark - Prepare For Reuse

- (void) prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = nil;
}

#pragma mark - Setup

- (void) setup {
    [self setupStyle];
    [self setupImageView];
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

@end

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
    [self setupImageView];
}

- (void) setupImageView {
    CGFloat width = self.frame.size.width;
    CGFloat height = width * 0.61f;
    [self addSubview: self.imageView];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.backgroundColor = [UIColor colorWithHex: @"#efefef"];
    self.imageView.image = [UIImage imageNamed: @"placeholder"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.layer.masksToBounds = YES;
    [NSLayoutConstraint activateConstraints: @[
        [self.imageView.widthAnchor constraintEqualToConstant: width],
        [self.imageView.heightAnchor constraintEqualToConstant: height]
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
    }
}

@end

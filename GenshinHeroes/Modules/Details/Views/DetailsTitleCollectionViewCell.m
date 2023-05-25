//
//  DetailsTitleCollectionViewCell.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/24/23.
//

#import "DetailsTitleCollectionViewCell.h"

@interface DetailsTitleCollectionViewCell ()

@property (strong, nonatomic) UILabel* titleLabel;

@end


@implementation DetailsTitleCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self initValues];
        [self setup];
    }
    return self;
}

- (UICollectionViewLayoutAttributes*) preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*) layoutAttributes {
    CGSize targetSize = CGSizeMake(layoutAttributes.frame.size.width, 0);
    [layoutAttributes setSize: [self.contentView systemLayoutSizeFittingSize: targetSize withHorizontalFittingPriority: UILayoutPriorityRequired verticalFittingPriority: UILayoutPriorityFittingSizeLevel]];
    return layoutAttributes;
}

- (void) initValues {
    self.titleLabel = [[UILabel alloc] init];
}

#pragma mark - Prepare For Reuse

- (void) prepareForReuse {
    [super prepareForReuse];
    self.titleLabel.text = @"";
}

#pragma mark - Setup

- (void) setup {
    [self setupTitleLabel];
}


- (void) setupTitleLabel {
    [self addSubview: self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.textColor = Colors.shared.text[@"primary"];
    self.titleLabel.font = [UIFont fontWithName: @"Avenir Next Regular" size: 24.0];
    [NSLayoutConstraint activateConstraints: @[
        [self.titleLabel.leadingAnchor constraintEqualToAnchor: self.leadingAnchor],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor: self.trailingAnchor]
    ]];
}

- (void) updateWithSection: (DetailsSection*) section {
    self.titleLabel.text = section.title;
}

@end

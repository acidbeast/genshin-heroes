//
//  DetailsTextCollectionViewCell.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/30/23.
//

#import "DetailsTextCollectionViewCell.h"

@interface DetailsTextCollectionViewCell ()

@property (strong, nonatomic) UILabel* textLabel;

@end

@implementation DetailsTextCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self initValues];
        [self setup];
    }
    return self;
}

#pragma mark - Init Values

- (void) initValues {
    self.textLabel = [[UILabel alloc] init];
}

#pragma mark - Setup

- (void) setup {
    [self setupTextLabel];
}

- (void) setupTextLabel {
    [self addSubview: self.textLabel];
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.textLabel.numberOfLines = 0;
    [NSLayoutConstraint activateConstraints: @[
        [self.textLabel.topAnchor constraintEqualToAnchor: self.topAnchor],
        [self.textLabel.bottomAnchor constraintEqualToAnchor: self.bottomAnchor],
        [self.textLabel.leadingAnchor constraintEqualToAnchor: self.leadingAnchor],
        [self.textLabel.trailingAnchor constraintEqualToAnchor: self.trailingAnchor]
    ]];
}

#pragma mark - Update with section

- (void) updateWithSection: (DetailsSection*) section {
    self.textLabel.text = section.text;
}

@end

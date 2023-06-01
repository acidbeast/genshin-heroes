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
@property (assign, nonatomic) CGFloat columnWidth;

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
    self.columnWidth = (self.frame.size.width / 2) - 8;
}

- (void) setup {
    [self setupTitleLabel];
    [self setupValueLabel];
}

- (void) setupTitleLabel {
    [self addSubview: self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.font = [UIFont fontWithName: @"Avenir Next Regular" size: 15.0];
    [NSLayoutConstraint activateConstraints: @[
        [self.titleLabel.widthAnchor constraintEqualToConstant: self.columnWidth],
        [self.titleLabel.topAnchor constraintEqualToAnchor: self.topAnchor constant: 4],
        [self.titleLabel.bottomAnchor constraintEqualToAnchor: self.bottomAnchor constant: -4],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant: 4]
    ]];
}

- (void) setupValueLabel {
    [self addSubview: self.valueLabel];
    self.valueLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.valueLabel.font = [UIFont fontWithName: @"Avenir Next Regular" size: 15.0];
    [NSLayoutConstraint activateConstraints: @[
        [self.titleLabel.widthAnchor constraintEqualToConstant: self.columnWidth],
        [self.valueLabel.topAnchor constraintEqualToAnchor: self.topAnchor constant: 4],
        [self.valueLabel.bottomAnchor constraintEqualToAnchor: self.bottomAnchor constant: -4],
        [self.valueLabel.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant: -4]
    ]];
}

#pragma mark - Update with section

- (void) updateWithSection: (DetailsSection*) section  {
    self.titleLabel.text = section.title;
    self.valueLabel.text = section.value;
    if (section.background) {
        self.backgroundColor = Colors.shared.background[@"primary"];
    }
}


@end

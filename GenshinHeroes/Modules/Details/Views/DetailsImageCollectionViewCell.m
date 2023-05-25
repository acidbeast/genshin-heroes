//
//  DetailsImageCollectionViewCell.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/24/23.
//

#import "DetailsImageCollectionViewCell.h"

@interface DetailsImageCollectionViewCell ()

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
    
}


#pragma mark - Prepare For Reuse

- (void) prepareForReuse {
    [super prepareForReuse];
}

#pragma mark - Setup

- (void) setup {
    NSLog(@"DetailsImageCollectionViewCell setup");
    UILabel* label = [[UILabel alloc] init];
    label.text = @"Image";
    label.textColor = [UIColor blackColor];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: label];
    [NSLayoutConstraint activateConstraints: @[
        [label.leadingAnchor constraintEqualToAnchor: self.leadingAnchor],
        [label.trailingAnchor constraintEqualToAnchor: self.trailingAnchor]
    ]];
}

- (void) updateWithSection: (DetailsSection*) section {
    NSLog(@"section: %@", section);
}

@end

//
//  EmptyView.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/19/23.
//

#import "EmptyView.h"

@interface EmptyView ()

@property (strong, nonatomic) UIImageView* imageView;
@property (strong, nonatomic) UILabel* textLabel;
@property (strong, nonatomic) NSString* text;

@end

@implementation EmptyView

- (instancetype) initWithText: (NSString*) text {
    self = [super initWithFrame: CGRectZero];
    if (self) {
        self.text = text;
        [self onInit];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self onInit];
    }
    return self;
}

- (void) onInit {
    self.imageView = [[UIImageView alloc] init];
    self.textLabel = [[UILabel alloc] init];
    [self setup];
}

- (void) setup {
    self.backgroundColor = [UIColor colorWithHex: @"#ebeaef"];
    [self setupImageView];
    [self setupTextLabel];
}

- (void) setupImageView {
    [self addSubview: self.imageView];
    self.imageView.image = [UIImage imageNamed: @"placeholder"];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.imageView.widthAnchor constraintEqualToConstant: 200],
        [self.imageView.heightAnchor constraintEqualToConstant: 200],
        [self.imageView.centerXAnchor constraintEqualToAnchor: self.centerXAnchor],
        [self.imageView.centerYAnchor constraintEqualToAnchor: self.centerYAnchor constant: 40]
    ]];
}

- (void) setupTextLabel {
    [self addSubview: self.textLabel];
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.textLabel.text = self.text;
    self.textLabel.numberOfLines = 0;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont fontWithName: @"Avenir Next Regular" size: 24.0];
    self.textLabel.textColor = [UIColor darkGrayColor];
    [NSLayoutConstraint activateConstraints: @[
        [self.textLabel.centerXAnchor constraintEqualToAnchor: self.centerXAnchor],
        [self.textLabel.topAnchor constraintEqualToAnchor: self.imageView.bottomAnchor constant: 30]
    ]];
}

@end

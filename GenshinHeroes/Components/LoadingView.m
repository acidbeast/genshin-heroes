//
//  LoadingView.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/24/23.
//

#import "LoadingView.h"

@interface LoadingView ()

@property (strong, nonatomic) UIImageView* imageView;
@property (strong, nonatomic) UILabel* textLabel;

@end

@implementation LoadingView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.textLabel = [[UILabel alloc] init];
        [self setup];
    }
    return self;
}

- (void) setup {
    self.backgroundColor = [UIColor colorWithHex: @"#ebeaef"];
    [self setupImageView];
    [self setupTextLabel];
}

- (void) setupImageView {
    [self addSubview: self.imageView];
    self.imageView.image = [UIImage imageNamed: @"logo"];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.imageView.widthAnchor constraintEqualToConstant: 200],
        [self.imageView.heightAnchor constraintEqualToConstant: 200],
        [self.imageView.centerXAnchor constraintEqualToAnchor: self.centerXAnchor],
        [self.imageView.centerYAnchor constraintEqualToAnchor: self.centerYAnchor]
    ]];
}

- (void) setupTextLabel {
    [self addSubview: self.textLabel];
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.textLabel.text = @"Loading";
    self.textLabel.font = [UIFont fontWithName: @"Avenir Next Regular" size: 24.0];
    self.textLabel.textColor = [UIColor blackColor];
    [NSLayoutConstraint activateConstraints: @[
        [self.textLabel.centerXAnchor constraintEqualToAnchor: self.centerXAnchor],
        [self.textLabel.topAnchor constraintEqualToAnchor: self.imageView.bottomAnchor constant: 30]
    ]];
}

@end

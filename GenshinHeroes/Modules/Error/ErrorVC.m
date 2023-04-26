//
//  ErrorVC.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/26/23.
//

#import "ErrorVC.h"

@interface ErrorVC ()

@property (strong, nonatomic) UIImageView* imageView;
@property (strong, nonatomic) UILabel* textLabel;
@property (strong, nonatomic) UIButton* actionButton;

@end

@implementation ErrorVC

- (instancetype) initWithViewModel: (ErrorVM*) viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.imageView = [[UIImageView alloc] init];
        self.textLabel = [[UILabel alloc] init];
        self.actionButton = nil;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

#pragma mark - Setup

- (void) setup {
    self.view.backgroundColor = [UIColor colorWithHex: @"#ebeaef"];
    [self setupNavigation];
    [self setupImageView];
    [self setupTextLabel];
    [self setupButton];
}

- (void) setupNavigation {
    [self.navigationController setNavigationBarHidden: YES];
}

- (void) setupImageView {
    [self.view addSubview: self.imageView];
    self.imageView.image = [UIImage imageNamed: @"logo"];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.imageView.widthAnchor constraintEqualToConstant: 200],
        [self.imageView.heightAnchor constraintEqualToConstant: 200],
        [self.imageView.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor],
        [self.imageView.centerYAnchor constraintEqualToAnchor: self.view.centerYAnchor constant: 40]
    ]];
}

- (void) setupTextLabel {
    [self.view addSubview: self.textLabel];
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.textLabel.text = self.viewModel.text;
    self.textLabel.font = [UIFont fontWithName: @"Avenir Next Regular" size: 18.0];
    self.textLabel.textColor = [UIColor colorWithHex: @"#c40000"];
    [NSLayoutConstraint activateConstraints: @[
        [self.textLabel.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor],
        [self.textLabel.topAnchor constraintEqualToAnchor: self.imageView.bottomAnchor constant: 30]
    ]];
}

- (void) setupButton {
    if (self.viewModel.showButton == NO) { return; }
    __weak ErrorVC* weakSelf = self;
    UIButtonConfiguration* configuration = [UIButtonConfiguration filledButtonConfiguration];
    configuration.title = self.viewModel.buttonText;
    configuration.baseBackgroundColor = [UIColor blackColor];
    configuration.cornerStyle = UIButtonConfigurationCornerStyleLarge;
    UIAction* action = [UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        if (weakSelf.viewModel.actionBlock != nil) {
            weakSelf.viewModel.actionBlock();
        }
    }];
    self.actionButton = [UIButton buttonWithConfiguration: configuration primaryAction: action];
    [self.view addSubview: self.actionButton];
    self.actionButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.actionButton.heightAnchor constraintEqualToConstant: 48],
        [self.actionButton.topAnchor constraintEqualToAnchor: self.textLabel.bottomAnchor constant: 30],
        [self.actionButton.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor]
    ]];
}

@end

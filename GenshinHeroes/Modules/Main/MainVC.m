//
//  MainVC.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 3/11/23.
//

#import "MainVC.h"


@interface MainVC ()
@property (strong, nonatomic) LoadingView* loadingView;
@end

@implementation MainVC

- (instancetype) initWithViewModel: (MainVM*) viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.viewModel.delegate = self;
        self.loadingView = [[LoadingView alloc] initWithFrame: CGRectZero];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self.viewModel fetchCharacters];
}

#pragma mark - Setup

- (void) setup {
    [self setupLoadingView];
}

- (void) setupLoadingView {
    [self.view addSubview: self.loadingView];
    self.loadingView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.loadingView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [self.loadingView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
        [self.loadingView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        [self.loadingView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor]
    ]];
}

#pragma mark - MainVMDelegateProtocol

- (void) onFetchCharactersLoading {
    NSLog(@"onFetchCharactersLoading");
}

- (void) onFetchCharactersSuccess {
    NSLog(@"onFetchCharactersSuccess");
}

- (void) onFetchCharactersError: (NSError*) error {
    NSLog(@"onFetchCharactersError: %@", error.localizedDescription);
}

@end

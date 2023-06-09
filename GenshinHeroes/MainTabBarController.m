//
//  MainTabBarController.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/17/23.
//

#import "MainTabBarController.h"
#import "UIWindow+keyWindow.h"


@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self moveFrameDown];
}

#pragma mark - Setup

- (void) setup {
    [self setupStyle];
    [self setupAppearance];
}

- (void) setupStyle {
    self.tabBar.tintColor = [UIColor blackColor];
    self.tabBar.layer.cornerRadius = 16;
    self.tabBar.layer.masksToBounds = YES;
}

- (void) setupAppearance {
    UITabBarAppearance* appearance = [[UITabBarAppearance alloc] init];
    [appearance configureWithTransparentBackground];
    appearance.backgroundColor = [UIColor whiteColor];
    [self.tabBar setStandardAppearance: appearance];
    [self.tabBar setScrollEdgeAppearance: appearance];
}

#pragma mark - Methods

- (void) moveFrameToY: (CGFloat) newY {
    [self.tabBar setFrame: CGRectMake(0, newY, CGRectGetWidth(self.tabBar.frame), CGRectGetHeight(self.tabBar.frame))];
}

- (void) moveFrameDown {
    [self moveFrameToY: CGRectGetMaxY([[UIWindow keyWindow] frame]) + CGRectGetHeight(self.tabBar.frame)];
}

- (void) moveFrameUp {
    [self moveFrameToY: CGRectGetMaxY([[UIWindow keyWindow] frame]) - CGRectGetHeight(self.tabBar.frame)];
}

- (void) animateTabBar: (EmptyBlock) animationBlock
            completion: (void(^)(BOOL completed)) completionBlock {
    [UIView animateWithDuration: 1
                          delay: 0.2
         usingSpringWithDamping: 0.8
          initialSpringVelocity: 0.7
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
        animationBlock();
        [self.navigationController.view layoutIfNeeded];
    }
                     completion: completionBlock];
}

- (void) showTabBarWithAnimation {
    [self.tabBar setHidden: NO];
    [self animateTabBar: ^{
        [self moveFrameUp];
    } completion: nil];
}

- (void) hideTabBarWithAnimation {
    __weak MainTabBarController* weakSelf = self;
    [self animateTabBar: ^{
        [self moveFrameDown];
    } completion:^(BOOL completed) {
        [weakSelf.tabBar setHidden: YES];
    }];
}

@end

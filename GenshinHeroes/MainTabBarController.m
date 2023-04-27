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
    self.view.backgroundColor = [UIColor colorWithHex: @"#ebeaef"];
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = [UIColor blackColor];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.layer.cornerRadius = 16;
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

- (void) animateTabBar: (void(^)(void)) animationBlock {
    [UIView animateWithDuration: 1
                          delay: 0.2
         usingSpringWithDamping: 0.8
          initialSpringVelocity: 0.7
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
        animationBlock();
        [self.navigationController.view layoutIfNeeded];
    }
                     completion: nil];
}

- (void) showTabBarWithAnimation {
    [self animateTabBar: ^{
        [self moveFrameUp];
    }];
}

- (void) hideTabBarWithAnimation {
    [self animateTabBar: ^{
        [self moveFrameDown];
    }];
}

@end

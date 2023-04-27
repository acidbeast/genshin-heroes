//
//  MainTabBarController.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/17/23.
//

#import "MainTabBarController.h"


@interface MainTabBarController ()

@end

@implementation MainTabBarController

const int kTabBarHeight = 100;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex: @"#ebeaef"];
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = [UIColor blackColor];
    self.tabBar.backgroundColor = [UIColor whiteColor];
}

- (void) showTabBarWithAnimation {
    [self.tabBar setHidden: NO];
    [UIView animateWithDuration: 0.7
                          delay: 1
         usingSpringWithDamping: 0.8
          initialSpringVelocity: 0.7
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
        CGRect frame = self.navigationController.view.frame;
        [self.tabBar setFrame: CGRectMake(0, CGRectGetMaxY(frame) + CGRectGetHeight(frame), CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [self.navigationController.view layoutIfNeeded];
    }
                     completion: nil];
}

- (void) hideTabBarWithAnimation {
    [UIView animateWithDuration: 0.7
                          delay: 1
         usingSpringWithDamping: 0.8
          initialSpringVelocity: 0.7
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
        CGRect frame = self.navigationController.view.frame;
        [self.tabBar setFrame: CGRectMake(0, CGRectGetMaxY(frame) - CGRectGetHeight(frame), CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [self.navigationController.view layoutIfNeeded];
    }
                     completion: ^(BOOL animated){
        [self.tabBar setHidden: YES];
    }];
}

@end

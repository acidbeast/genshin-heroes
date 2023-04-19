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
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = [UIColor blackColor];
    self.tabBar.backgroundColor = [UIColor whiteColor];
}

@end

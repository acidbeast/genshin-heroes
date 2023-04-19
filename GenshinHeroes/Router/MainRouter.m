//
//  MainRouter.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/14/23.
//

#import <UIKit/UIKit.h>
#import "MainRouter.h"

@interface MainRouter ()

@property (strong, nonatomic) UINavigationController* mainNC;
@property (strong, nonatomic) UINavigationController* favoritesNC;

@end

@implementation MainRouter

- (instancetype)initWithModuleBuilder: (ModuleBuilder*) moduleBuilder
                 tabBarController: (UITabBarController*) tabBarController {
    self = [super init];
    if (self) {
        self.moduleBuilder = moduleBuilder;
        self.tabBarController = tabBarController;
        self.mainNC = [self.moduleBuilder createMainNavController];
        self.favoritesNC = [self.moduleBuilder createFavoritesNavController];
    }
    return self;
}

- (void)start {
    UIViewController* mainVC = [self.moduleBuilder createMainModuleWithRouter: self];
    UIViewController* favoritesVC = [self.moduleBuilder createFavoritesModuleWithRouter: self];
    self.mainNC.viewControllers = @[mainVC];
    self.favoritesNC.viewControllers = @[favoritesVC];
    self.tabBarController.viewControllers = @[self.mainNC, self.favoritesNC];
    self.tabBarController.selectedIndex = 0;
}

@end

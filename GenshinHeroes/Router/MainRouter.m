//
//  MainRouter.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/14/23.
//

#import <UIKit/UIKit.h>
#import "MainRouter.h"

@class MainTabBarController;

@interface MainRouter ()

@property (strong, nonatomic) UINavigationController* mainNC;
@property (strong, nonatomic) UINavigationController* favoritesNC;

@end

@implementation MainRouter

- (instancetype) initWithModuleBuilder: (ModuleBuilder*) moduleBuilder
                 tabBarController: (MainTabBarController*) tabBarController {
    self = [super init];
    if (self) {
        self.moduleBuilder = moduleBuilder;
        self.tabBarController = tabBarController;
        self.mainNC = [self.moduleBuilder createMainNavController];
        self.favoritesNC = [self.moduleBuilder createFavoritesNavController];
    }
    return self;
}

- (void) start {
    UIViewController* mainVC = [self.moduleBuilder createMainModuleWithRouter: self];
    UIViewController* favoritesVC = [self.moduleBuilder createFavoritesModuleWithRouter: self];
    self.mainNC.viewControllers = @[mainVC];
    self.favoritesNC.viewControllers = @[favoritesVC];
    self.tabBarController.viewControllers = @[self.mainNC, self.favoritesNC];
    self.tabBarController.selectedIndex = 0;
}

- (void) showTabBar {
    [self.tabBarController showTabBarWithAnimation];
}

- (void) hideTabBar {
    [self.tabBarController hideTabBarWithAnimation];
}

- (void) showErrorWithText: (NSString*) errorText
                buttonText: (NSString*) buttonText
               actionBlock: (ErrorActionBlock) actionBlock {
    UIViewController* errorVC = [self.moduleBuilder createErrorModuleWithRouter: self errorText: errorText buttonText: buttonText actionBlock: actionBlock];
    UINavigationController* navigationController = [self.tabBarController selectedViewController];
    [navigationController pushViewController: errorVC animated: YES];
}

- (void) showHeroDetailsWithName: (NSString*) name {
    UIViewController* heroDetailsVC = [self.moduleBuilder createHeroDetailsModuleWithRouter: self heroName: name];
    UINavigationController* navigationController = [self.tabBarController selectedViewController];
    [navigationController pushViewController: heroDetailsVC animated: YES];
}

@end

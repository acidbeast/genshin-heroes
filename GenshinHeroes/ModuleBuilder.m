//
//  ModuleBuilder.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/14/23.
//

#import <UIKit/UIKit.h>
#import "ModuleBuilder.h"
#import "Modules/Main/MainVC.h"
#import "Modules/Favorites/FavoritesVC.h"


@implementation ModuleBuilder

- (UINavigationController*) createMainNavController {
    MainVC* vc = [[MainVC alloc] init];
    UINavigationController* navigationContoller = [[UINavigationController alloc] init];
    UITabBarItem* tabBarItem = [[UITabBarItem alloc] initWithTitle: @"Home"
                                                             image: [UIImage systemImageNamed: @"house"]
                                                     selectedImage: [UIImage systemImageNamed: @"house.fill"]];
    tabBarItem.badgeColor = [UIColor redColor];
    navigationContoller.viewControllers = @[vc];
    navigationContoller.tabBarItem = tabBarItem;
    return navigationContoller;
}


- (UINavigationController*) createFavoritesNavController {
    UINavigationController* navigationContoller = [[UINavigationController alloc] init];
    UITabBarItem* tabBarItem = [
        [UITabBarItem alloc]
        initWithTitle: @"Favorites"
        image: [UIImage systemImageNamed: @"star"]
        selectedImage: [UIImage systemImageNamed: @"star.fill"]
    ];
    tabBarItem.badgeColor = [UIColor redColor];
    navigationContoller.tabBarItem = tabBarItem;
    return navigationContoller;
}

- (UIViewController*) createMainModuleWithRouter: (MainRouter*) router {
    MainVC* vc = [[MainVC alloc] init];
    return vc;
}

- (UIViewController*) createFavoritesModuleWithRouter: (MainRouter*) router {
    FavoritesVC* vc = [[FavoritesVC alloc] init];
    return vc;
}


@end

//
//  ModuleBuilder.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/14/23.
//

#import <UIKit/UIKit.h>
#import "ModuleBuilder.h"

@implementation ModuleBuilder

- (UINavigationController*) createNavControllerWithTabTitle: (NSString*) title
                                               imageName: (NSString*) imageName
                                       selectedImageName: (NSString*) selectedImageName {
    UINavigationController* navigationContoller = [[UINavigationController alloc] init];
    UITabBarItem* tabBarItem = [[UITabBarItem alloc] initWithTitle: title
                                                             image: [UIImage systemImageNamed: imageName]
                                                     selectedImage: [UIImage systemImageNamed: selectedImageName]];
    tabBarItem.badgeColor = [UIColor redColor];
    navigationContoller.tabBarItem = tabBarItem;
    return navigationContoller;
}

- (UINavigationController*) createMainNavController
{
    return [self createNavControllerWithTabTitle: @"Home" imageName: @"house" selectedImageName: @"house.fill"];
}

- (UINavigationController*) createFavoritesNavController {
    return [self createNavControllerWithTabTitle: @"Favorites" imageName: @"star" selectedImageName: @"star.fill"];
}

- (UIViewController*) createMainModuleWithRouter: (MainRouter*) router {    
    MainVM* viewModel = [[MainVM alloc] initWithSettingsService: [SettingsService shared]
                                               characterService: [CharactersService shared]
                                                coreDataService: [CoreDataService shared]];
    MainVC* vc = [[MainVC alloc] initWithViewModel: viewModel];
    vc.router = router;
    return vc;
}

- (UIViewController*) createFavoritesModuleWithRouter: (MainRouter*) router {
    FavoritesVC* vc = [[FavoritesVC alloc] init];
    return vc;
}

@end

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
    return [self createNavControllerWithTabTitle: @"Favorites" imageName: @"heart" selectedImageName: @"heart.fill"];
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
    FavoritesVM* viewModel = [[FavoritesVM alloc] initWithcoreDataService: [CoreDataService shared]];
    FavoritesVC* vc = [[FavoritesVC alloc] initWithViewModel: viewModel];
    vc.router = router;
    return vc;
}

- (UIViewController*) createErrorModuleWithRouter: (MainRouter*) router
                                       errorText: (NSString*) errorText
                                      buttonText: (NSString*) buttonText
                                     actionBlock: (ErrorActionBlock) actionBlock {
    ErrorVM* viewModel = [[ErrorVM alloc] initWithText: errorText
                                            buttonText: buttonText
                                           actionBlock: actionBlock];
    ErrorVC* vc = [[ErrorVC alloc] initWithViewModel: viewModel];
    vc.router = router;
    return vc;
}

- (UIViewController*) createHeroDetailsModuleWithRouter: (MainRouter*) router
                                               heroName: (NSString*) heroName {
    HeroDetailsVM* viewModel = [[HeroDetailsVM alloc] initWithHeroName: heroName
                                                       coreDataService: [CoreDataService shared]];
    HeroDetailsVC* vc = [[HeroDetailsVC alloc] initWithViewModel: viewModel];
    vc.router = router;
    return vc;
}

@end

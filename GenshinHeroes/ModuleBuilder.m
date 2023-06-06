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
    CharactersService* service = [[CharactersService alloc] initWithNetworkProvider: [CharactersNetworkProvider shared] databaseProvider: [CharactersDatabaseProvider shared] settingsPrvider: [SettingsProvider shared]];
    MainVM* viewModel = [[MainVM alloc] initWithService: service];
    MainVC* vc = [[MainVC alloc] initWithViewModel: viewModel];
    vc.router = router;
    return vc;
}

- (UIViewController*) createFavoritesModuleWithRouter: (MainRouter*) router {
    FavoritesService* service = [[FavoritesService alloc] initWithDatabaseProvider: [FavoritesDatabaseProvider shared]];
    FavoritesVM* viewModel = [[FavoritesVM alloc] initWithFavoritesService: service];
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
    DetailsVM* viewModel = [[DetailsVM alloc] initWithHeroName: heroName
                                                       coreDataService: [CharactersDatabaseProvider shared]];
    DetailsVC* vc = [[DetailsVC alloc] initWithViewModel: viewModel];
    vc.router = router;
    return vc;
}

@end

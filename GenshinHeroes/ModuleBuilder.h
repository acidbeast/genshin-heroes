//
//  ModuleBuilder.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/14/23.
//

// Frameworks
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Modules
#import "MainVC.h"
#import "MainVM.h"
#import "ErrorVC.h"
#import "ErrorVM.h"
#import "FavoritesVC.h"
#import "FavoritesVM.h"

// Services
#import "SettingsService.h"
#import "CharactersService.h"
#import "CoreDataService.h"

@class MainRouter;

NS_ASSUME_NONNULL_BEGIN

@protocol ModuleBuilderProtocol <NSObject>

- (UINavigationController*) createNavControllerWithTabTitle: (NSString*) title imageName: (NSString*) imageName selectedImageName: (NSString*) selectedImageName;
- (UINavigationController*) createMainNavController;
- (UINavigationController*) createFavoritesNavController;
- (UIViewController*) createMainModuleWithRouter: (MainRouter*) router;
- (UIViewController*) createFavoritesModuleWithRouter: (MainRouter*) router;
- (UIViewController*) createErrorBlockWithRouter: (MainRouter*) router
                                       errorText: (NSString*) errorText
                                      buttonText: (NSString*) buttonText
                                     actionBlock: (ErrorActionBlock) actionBlock;

@end

@interface ModuleBuilder : NSObject <ModuleBuilderProtocol>

@end

NS_ASSUME_NONNULL_END

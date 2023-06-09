//
//  MainRouter.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/14/23.
//

@protocol DismissActionProtocol
- (void) dismissAction;
@end

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ModuleBuilder.h"
#import "MainTabBarController.h"
#import "ErrorVM.h"
#import "Blocks.h"


NS_ASSUME_NONNULL_BEGIN

@class ModuleBuilder;

@protocol MainRouterProtocol <NSObject>

- (void) start;
- (void) back;

@end

@interface MainRouter : NSObject <MainRouterProtocol>

@property (strong, nonatomic) ModuleBuilder* moduleBuilder;
@property (strong, nonatomic) MainTabBarController* tabBarController;

- (instancetype)initWithModuleBuilder: (ModuleBuilder*) moduleBuilder
                     tabBarController: (UITabBarController*) tabBarController;
- (void) start;
- (void) back;
- (void) backWithAction;
- (void) showTabBar;
- (void) hideTabBar;
- (void) showErrorWithText: (NSString*) errorText
                buttonText: (NSString*) buttonText
               actionBlock: (ErrorActionBlock __nullable) actionBlock;
- (void) showHeroDetailsWithName: (NSString*) name;

@end

NS_ASSUME_NONNULL_END

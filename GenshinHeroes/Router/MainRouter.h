//
//  MainRouter.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/14/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ModuleBuilder.h"
#import "ErrorVM.h"

NS_ASSUME_NONNULL_BEGIN

@class ModuleBuilder;

@protocol MainRouterProtocol <NSObject>

-(void) start;

@end

@interface MainRouter : NSObject <MainRouterProtocol>

@property (strong, nonatomic) ModuleBuilder* moduleBuilder;
@property (strong, nonatomic) UITabBarController* tabBarController;

- (instancetype)initWithModuleBuilder: (ModuleBuilder*) moduleBuilder
                     tabBarController: (UITabBarController*) tabBarController;
- (void) start;
- (void) showErrorWithText: (NSString*) errorText
                buttonText: (NSString*) buttonText
               actionBlock: (ErrorActionBlock __nullable) actionBlock;

@end

NS_ASSUME_NONNULL_END

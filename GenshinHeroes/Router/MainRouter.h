//
//  MainRouter.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/14/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ModuleBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MainRouterProtocol <NSObject>

-(void) start;

@end

@interface MainRouter : NSObject <MainRouterProtocol>

@property (strong, nonatomic) ModuleBuilder* moduleBuilder;
@property (strong, nonatomic) UITabBarController* tabBarController;

- (instancetype)initWithModuleBuilder: (ModuleBuilder*) moduleBuilder
                     tabBarController: (UITabBarController*) tabBarController;

@end

NS_ASSUME_NONNULL_END

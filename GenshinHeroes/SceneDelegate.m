//
//  SceneDelegate.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 3/11/23.
//

#import <UIKit/UIKit.h>
#import "SceneDelegate.h"
#import "AppDelegate.h"
#import "ModuleBuilder.h"
#import "Router/MainRouter.h"
#import "MainTabBarController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    ModuleBuilder* moduleBuilder = [[ModuleBuilder alloc] init];
    MainTabBarController* tabBarController = [[MainTabBarController alloc] init];
    MainRouter* mainRouter = [[MainRouter alloc] initWithModuleBuilder: moduleBuilder
                                                      tabBarController: tabBarController];
    [mainRouter start];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
}


- (void)sceneDidDisconnect:(UIScene *)scene {}
- (void)sceneDidBecomeActive:(UIScene *)scene {}
- (void)sceneWillResignActive:(UIScene *)scene {}
- (void)sceneWillEnterForeground:(UIScene *)scene {}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    [(AppDelegate *)UIApplication.sharedApplication.delegate saveContext];
}


@end

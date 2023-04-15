//
//  ModuleBuilder.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/14/23.
//

#import "ModuleBuilder.h"
#import <UIKit/UIKit.h>

#import "Modules/Main/MainVC.h"

@implementation ModuleBuilder

- (UIViewController*) createMainModuleWithRouter: (MainRouter*) router {
    MainVC* vc = [[MainVC alloc] init];
    return vc;
}

@end

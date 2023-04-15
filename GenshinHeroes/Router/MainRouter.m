//
//  MainRouter.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/14/23.
//

#import <UIKit/UIKit.h>
#import "MainRouter.h"
#import "ModuleBuilder.h"


@implementation MainRouter

- (instancetype)initWithModuleBuilder: (ModuleBuilder*) moduleBuilder
                 navigationController: (UINavigationController*) navigationController
{
    self = [super init];
    if (self) {
        self.moduleBuilder = moduleBuilder;
        self.navigationController = navigationController;
    }
    return self;
}

- (void)start {
    UIViewController* vc = [self.moduleBuilder createMainModuleWithRouter: self];
    if (self.navigationController != nil) {
        [self.navigationController pushViewController: vc animated: NO];
    }
}

@end

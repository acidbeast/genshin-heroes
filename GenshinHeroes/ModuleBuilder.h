//
//  ModuleBuilder.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/14/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MainRouter;

NS_ASSUME_NONNULL_BEGIN

@protocol ModuleBuilderProtocol <NSObject>

- (UIViewController*) createMainModuleWithRouter: (MainRouter*) router;

@end

@interface ModuleBuilder : NSObject <ModuleBuilderProtocol>

@end

NS_ASSUME_NONNULL_END

//
//  HeroDetailsVC.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/19/23.
//

#import <UIKit/UIKit.h>
#import "HeroDetailsVM.h"
#import "MainRouter.h"
#import "LoadingView.h"
#import "BackButton.h"

@class MainRouter;

NS_ASSUME_NONNULL_BEGIN

@interface HeroDetailsVC : UIViewController

@property (strong, nonatomic) MainRouter* router;
@property (strong, nonatomic) HeroDetailsVM* viewModel;

- (instancetype) initWithViewModel: (HeroDetailsVM*) viewModel;

@end

NS_ASSUME_NONNULL_END

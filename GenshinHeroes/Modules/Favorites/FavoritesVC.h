//
//  FavoritesVC.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/18/23.
//

#import <UIKit/UIKit.h>
#import "MainRouter.h"
#import "FavoritesVM.h"
#import "TwoColumnCollectionVC.h"
#import "LoadingView.h"
#import "UICollectionViewCell+Identifier.h"
#import "UIViewController+Notification.h"

NS_ASSUME_NONNULL_BEGIN

@class MainRouter;

@interface FavoritesVC : TwoColumnCollectionVC <FavoritesVMDelegateProtocol, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) MainRouter* router;
@property (strong, nonatomic) FavoritesVM* viewModel;

- (instancetype) initWithViewModel: (FavoritesVM*) viewModel;

@end

NS_ASSUME_NONNULL_END

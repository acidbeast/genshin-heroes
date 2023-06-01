//
//  HeroDetailsVC.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/19/23.
//

#import <UIKit/UIKit.h>
#import "DetailsVM.h"
#import "MainRouter.h"
#import "LoadingView.h"
#import "UICollectionViewCell+Identifier.h"

#import "DetailsImageCollectionViewCell.h"
#import "DetailsTitleCollectionViewCell.h"
#import "DetailsRatingCollectionViewCell.h"
#import "DetailsTextCollectionViewCell.h"
#import "DetailsTwoColumnCollectionViewCell.h"

@class MainRouter;

NS_ASSUME_NONNULL_BEGIN

@interface DetailsVC : UIViewController <DetailsVMDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) MainRouter* router;
@property (strong, nonatomic) DetailsVM* viewModel;

- (instancetype) initWithViewModel: (DetailsVM*) viewModel;

@end

NS_ASSUME_NONNULL_END

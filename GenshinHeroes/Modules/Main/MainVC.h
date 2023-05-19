//
//  MainVC.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 3/11/23.
//

#import <UIKit/UIKit.h>
#import "MainRouter.h"
#import "TwoColumnCollectionVC.h"
#import "MainVM.h"
#import "LoadingView.h"
#import "EmptyView.h"

@class MainRouter;

@interface MainVC : TwoColumnCollectionVC <MainVMDelegateProtocol, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) MainRouter* router;
@property (strong, nonatomic) MainVM* viewModel;

- (instancetype) initWithViewModel: (MainVM*) viewModel;

- (void) onFetchCharactersLoading;
- (void) onFetchCharactersSuccess;
- (void) onFetchCharactersError: (NSError*) error;

@end


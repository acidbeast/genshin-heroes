//
//  MainVC.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 3/11/23.
//

#import <UIKit/UIKit.h>
#import "MainRouter.h"
#import "MainVM.h"
#import "LoadingView.h"

@class MainRouter;

@interface MainVC : UIViewController <MainVMDelegateProtocol>

@property (strong, nonatomic) MainRouter* router;
@property (strong, nonatomic) MainVM* viewModel;

- (instancetype) initWithViewModel: (MainVM*) viewModel;

- (void) onFetchCharactersLoading;
- (void) onFetchCharactersSuccess;
- (void) onFetchCharactersError: (NSError*) error;

@end


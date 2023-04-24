//
//  MainVC.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 3/11/23.
//

#import <UIKit/UIKit.h>
#import "MainVM.h"

@class MainRouter;

@interface MainVC : UIViewController <MainVMDelegateProtocol>

@property (weak, nonatomic) MainRouter* router;
@property (strong, nonatomic) MainVM* viewModel;

- (instancetype) initWithViewModel: (MainVM*) viewModel;

- (void) onFetchCharactersLoading;
- (void) onFetchCharactersSuccess;
- (void) onFetchCharactersError: (NSError*) error;

@end


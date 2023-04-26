//
//  ErrorVC.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/26/23.
//

#import <UIKit/UIKit.h>
#import "ErrorVM.h"

NS_ASSUME_NONNULL_BEGIN

@class MainRouter;

@interface ErrorVC : UIViewController

@property (weak, nonatomic) MainRouter* router;
@property (strong, nonatomic) ErrorVM* viewModel;

- (instancetype) initWithViewModel: (ErrorVM*) viewModel;

@end

NS_ASSUME_NONNULL_END

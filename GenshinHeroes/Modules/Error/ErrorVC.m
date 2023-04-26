//
//  ErrorVC.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/26/23.
//

#import "ErrorVC.h"

@interface ErrorVC ()

@end

@implementation ErrorVC

- (instancetype) initWithViewModel: (ErrorVM*) viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
}

@end

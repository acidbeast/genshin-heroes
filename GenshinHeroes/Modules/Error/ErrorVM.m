//
//  ErrorVM.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/26/23.
//

#import "ErrorVM.h"

@implementation ErrorVM

- (instancetype) initWithText: (NSString*) text
                   buttonText: (NSString*) buttonText
                  actionBlock: (ErrorActionBlock) actionBlock {
    self = [super init];
    if (self) {
        self.text = text;
        self.showButton = actionBlock != nil;
        self.buttonText = buttonText;
        self.actionBlock = actionBlock;
    }
    return self;
}

@end

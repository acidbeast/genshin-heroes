//
//  ErrorVM.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/26/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ErrorActionBlock)(void);

@interface ErrorVM : NSObject

@property (strong, nonatomic) NSString* text;
@property (assign, nonatomic) BOOL showButton;
@property (copy, nonatomic) ErrorActionBlock actionBlock;

- (instancetype) initWithText: (NSString*) text actionBlock: (ErrorActionBlock) actionBlock;

@end

NS_ASSUME_NONNULL_END

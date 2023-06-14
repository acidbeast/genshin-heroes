//
//  NotificationModel.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/13/23.
//

#import <Foundation/Foundation.h>
#import "Blocks.h"

NS_ASSUME_NONNULL_BEGIN

@interface NotificationModel : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* text;
@property (copy, nonatomic) EmptyBlock action;
- (instancetype) initWithTitle: (NSString*) title
                          text: (NSString*) text
                        action: (EmptyBlock) action;

@end

NS_ASSUME_NONNULL_END

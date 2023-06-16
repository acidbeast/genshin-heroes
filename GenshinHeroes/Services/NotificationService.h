//
//  NotificationService.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/15/23.
//

#import <UIKit/UIKit.h>
#import "Blocks.h"
#import "NotificationModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NotificationServiceProtocol

- (void) showNotificationWithTitle: (NSString*) title
                              text: (NSString*) text
                            action: (EmptyBlock) action;

@end

@interface NotificationService : NSObject <NotificationServiceProtocol>

+ (instancetype) shared;
- (void) showNotificationWithTitle: (NSString*) title
                              text: (NSString*) text
                            action: (EmptyBlock) action;

@end

NS_ASSUME_NONNULL_END

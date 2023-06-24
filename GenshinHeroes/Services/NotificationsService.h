//
//  NotificationService.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/15/23.
//

#import <UIKit/UIKit.h>
#import "Blocks.h"
#import "NotificationModel.h"
#import "NotificationView.h"
#import "NotificationVM.h"
#import "UIWindow+keyWindow.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NotificationsServiceProtocol

- (void) showNotificationWithTitle: (NSString*) title
                              text: (NSString*) text
                              type: (NotificationType) type
                            action: (EmptyBlock _Nullable) action;

@end

@interface NotificationsService : NSObject <NotificationsServiceProtocol, NotificationViewProtocol>

+ (instancetype) shared;
- (void) showNotificationWithTitle: (NSString*) title
                              text: (NSString*) text
                              type: (NotificationType) type
                            action: (EmptyBlock _Nullable) action;

@end

NS_ASSUME_NONNULL_END

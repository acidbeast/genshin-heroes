//
//  UIViewController+Notification.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/15/23.
//

#import <UIKit/UIKit.h>
#import "NotificationService.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController(Notification)

+ (void) showNotificationWitTitle: (NSString*) title
                             text: (NSString*) text
                           action: (EmptyBlock) action;

@end

NS_ASSUME_NONNULL_END

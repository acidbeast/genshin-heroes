//
//  UIViewController+Notification.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/15/23.
//

#import "UIViewController+Notification.h"

@implementation UIViewController(Notification)

+ (void) showNotificationWitTitle: (NSString*) title
                             text: (NSString*) text
                           action: (EmptyBlock) action {
     [[NotificationService shared] showNotificationWithTitle: title
                                                        text: text
                                                      action: action];
}

@end

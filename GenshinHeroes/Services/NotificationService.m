//
//  NotificationService.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/15/23.
//

#import "NotificationService.h"

@implementation NotificationService

+ (instancetype) shared {
    static NotificationService* service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[NotificationService alloc] init];
    });
    return service;
}

- (void) showNotificationWithTitle: (NSString*) title
                              text: (NSString*) text
                            action: (EmptyBlock) action {
    NotificationModel* model = [[NotificationModel alloc] init];
    model.title = title;
    model.text = text;
    model.action = action;
    NSLog(@"Show notification: %@", model.title);
}

@end

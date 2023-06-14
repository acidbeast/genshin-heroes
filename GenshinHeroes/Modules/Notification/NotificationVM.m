//
//  NotificationVM.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/13/23.
//

#import "NotificationVM.h"


@implementation NotificationVM

- (instancetype) initWithType: (NotificationType) type
                        model: (NotificationModel*) model {
    self = [super init];
    if (self) {
        self.textColor = [self textColorValueWithType: type];
        self.backgroundColor = [self backgroundColorValueWithType: type];
        self.title = model.title;
        self.text = model.text;
        self.action = model.action;
    }
    return self;
}

- (UIColor*) textColorValueWithType: (NotificationType) type {
    UIColor* color = nil;
    switch (type) {
        case NotificationTypeSuccess:
            color = Colors.shared.text[@"white"];
            break;
            
        case NotificationTypeError:
            color = Colors.shared.text[@"white"];
            break;
        
        case NotificationTypeInfo:
            color = Colors.shared.text[@"primary"];
            break;
            
        default:
            color= Colors.shared.text[@"white"];
            break;
    }
    return color;
}

- (UIColor*) backgroundColorValueWithType: (NotificationType) type {
    UIColor* color = nil;
    switch (type) {
        case NotificationTypeSuccess:
            color = Colors.shared.background[@"success"];
            break;
            
        case NotificationTypeError:
            color = Colors.shared.text[@"error"];
            break;
        
        case NotificationTypeInfo:
            color = Colors.shared.text[@"primary"];
            break;
            
        default:
            color= Colors.shared.text[@"primary"];
            break;
    }
    return color;
}

@end

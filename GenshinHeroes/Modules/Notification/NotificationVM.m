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
        self.title = model.title;
        self.text = model.text;
        self.textColor = Colors.shared.text[@"primary"];
        self.backgroundColor = Colors.shared.background[@"white"];
        self.iconName = [self getIconNameWithType: type];
        self.action = model.action;
        self.type = type;
    }
    return self;
}

- (NSString*) getIconNameWithType: (NotificationType) type {
    NSString* iconName = nil;
    switch (type) {
        case NotificationTypeSuccess:
            iconName = @"icon_status_success_16x16";
            break;
            
        case NotificationTypeError:
            iconName = @"icon_status_error_16x16";
            break;
        
        case NotificationTypeWarning:
            iconName = @"icon_status_warning_16x16";
            break;
            
        default:
            break;
    }
    return iconName;
}

@end

//
//  NotificationModel.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/13/23.
//

#import "NotificationModel.h"

@implementation NotificationModel

- (instancetype) initWithTitle: (NSString*) title
                          text: (NSString*) text
                        action: (EmptyBlock) action {
    self = [super init];
    if (self) {
        self.title = title;
        self.text = text;
        self.action = action;
    }
    return self;
}

@end

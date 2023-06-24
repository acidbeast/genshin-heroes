//
//  NotificationService.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/15/23.
//

#import "NotificationsService.h"


@interface NotificationsService ()

@property (strong, nonatomic) NSMutableArray* notifications;
@property (strong, nonatomic) NSTimer* timer;
@property (assign, nonatomic) CGFloat timerInterval;

@end


@implementation NotificationsService

- (instancetype) init {
    self = [super init];
    if (self) {
        self.notifications = [[NSMutableArray alloc] init];
        self.timerInterval = 0.3;
    }
    return self;
}

+ (instancetype) shared {
    static NotificationsService* service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[NotificationsService alloc] init];
    });
    return service;
}

- (void) showNotificationWithTitle: (NSString*) title
                              text: (NSString*) text
                              type: (NotificationType) type
                            action: (EmptyBlock) action {
    if ([self checkForDuplicates: title text: text type: type]) {
        return;
    }
    NotificationModel* model = [[NotificationModel alloc] initWithTitle: title text: text action: action];
    NotificationVM* viewModel = [[NotificationVM alloc] initWithType: type model: model];
    [self.timer invalidate];
    [self.notifications addObject: viewModel];
    [self runTimer];
}

- (void) showNotificationWith: (NotificationVM*) viewModel {
    UIWindow* window = [UIWindow keyWindow];
    NotificationView* view = [[NotificationView alloc] initWithViewModel: viewModel window: window];
    view.delegate = self;
    view.duration = [self getNotificationDurationWith: viewModel.type];
    [window addSubview: view];
}

- (CGFloat) getNotificationDurationWith: (NotificationType) type {
    CGFloat value = 0;
    switch (type) {
        case NotificationTypeSuccess:
            value = 2.0;
            break;
        case NotificationTypeError:
            value = 3.0;
            break;
        case NotificationTypeWarning:
            value = 3.0;
            break;
        case NotificationTypeInfo:
            value = 3.0;
            break;
    }
    return value;
}

- (BOOL) checkForDuplicates: (NSString*) title
                       text: (NSString*) text
                       type: (NotificationType) type {
    for (NotificationVM* viewModel in self.notifications) {
        if (viewModel.title == title && viewModel.text == text && viewModel.type == type) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Timer

- (void) runTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval: self.timerInterval
                                                  target: self
                                                selector: @selector(updateTimer:)
                                                userInfo: nil
                                                 repeats: YES];
}

- (void) updateTimer: (NSTimer*) sender {
    if (self.notifications.count == 0) {
        return;
    }
    [sender invalidate];
    [self showNotificationWith: [self.notifications lastObject]];
    [self.notifications removeLastObject];
}

#pragma mark - Notification View Delegate

- (void) notifictionWillClose: (NotificationView*) notificationView {
    [notificationView closeWithAnimation];
}

- (void) notificationDidShow {}

- (void) notificationDidClose {
    [self runTimer];
}
- (void) notificationDidTap {}

@end

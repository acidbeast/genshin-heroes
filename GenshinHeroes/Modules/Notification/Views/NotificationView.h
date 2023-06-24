//
//  NotificationView.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/13/23.
//

#import <UIKit/UIKit.h>
#import "NotificationVM.h"

NS_ASSUME_NONNULL_BEGIN

@class NotificationView;

@protocol NotificationViewProtocol
- (void) notifictionWillClose: (NotificationView*) notificationView;
- (void) notificationDidShow;
- (void) notificationDidClose;
- (void) notificationDidTap;
@end

@interface NotificationView : UIView

@property (weak, nonatomic) id<NotificationViewProtocol> _Nullable delegate;
@property (assign, nonatomic) CGFloat duration;

- (instancetype) initWithViewModel: (NotificationVM*) viewModel window: (UIWindow*) window;
- (void) showWithAnimation;
- (void) closeWithAnimation;

@end


NS_ASSUME_NONNULL_END

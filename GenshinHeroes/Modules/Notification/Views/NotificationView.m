//
//  NotificationView.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/13/23.
//

#import "NotificationView.h"

@interface NotificationView ()

@property (strong, nonatomic) NotificationVM* viewModel;
@property (strong, nonatomic) UIView* containerView;
@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UILabel* textLabel;
@property (strong, nonatomic) UIImageView* iconImageView;
@property (strong, nonatomic) UIWindow* window;
@property (assign, nonatomic) CGFloat windowWidth;
@property (assign, nonatomic) CGFloat messageHeight;

@property (strong, nonatomic) NSTimer* timer;
@property (strong, nonatomic) UITapGestureRecognizer* tapGesture;

@end

@implementation NotificationView

- (instancetype) initWithViewModel: (NotificationVM*) viewModel window: (UIWindow*) window {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.window = window;
        self.windowWidth = window.frame.size.width;
        self.messageHeight = [self calculateMessageHeightWith:self.viewModel.title text: self.viewModel.text];
        self.duration = 0;
        self.containerView = [[UIView alloc] init];
        self.titleLabel = [[UILabel alloc] init];
        self.textLabel = [[UILabel alloc] init];
        self.iconImageView = [[UIImageView alloc] init];
        [self setup];
        [self showWithAnimation];
    }
    return self;
}

#pragma mark - Setup

- (void) setup {
    self.frame = [self calculateFrameWith: self.messageHeight];
    [self setupContainer];
    [self setupIcon];
    [self setupTitleLabel];
    [self setupTextLabel];
    [self addTapGestureRecognizer];
}

- (void) setupContainer {
    [self addSubview: self.containerView];
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.containerView.backgroundColor = self.viewModel.backgroundColor;
    self.containerView.layer.cornerRadius = 12;
    self.containerView.layer.borderWidth = 0;
    self.containerView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.containerView.layer.shadowOffset = CGSizeMake(0, 0);
    self.containerView.layer.shadowRadius = 8.f;
    self.containerView.layer.shadowOpacity = 0.1f;
    self.containerView.layer.masksToBounds = NO;
    self.containerView.layer.opacity = 0;
    self.containerView.tintColor = self.viewModel.textColor;
    [NSLayoutConstraint activateConstraints: @[
        [self.containerView.heightAnchor constraintEqualToConstant: self.messageHeight],
        [self.containerView.topAnchor constraintEqualToAnchor: self.topAnchor constant: self.window.safeAreaInsets.top],
        [self.containerView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant: 16],
        [self.containerView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant: -16]
    ]];
}

- (void) setupIcon {
    if (self.viewModel.type == NotificationTypeInfo) {
        return;
    }
    [self.containerView addSubview: self.iconImageView];
    self.iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.iconImageView.image = [UIImage imageNamed: self.viewModel.iconName];
    [NSLayoutConstraint activateConstraints: @[
        [self.iconImageView.widthAnchor constraintEqualToConstant: 16],
        [self.iconImageView.heightAnchor constraintEqualToConstant: 16],
        [self.iconImageView.topAnchor constraintEqualToAnchor: self.containerView.topAnchor constant: 18],
        [self.iconImageView.leadingAnchor constraintEqualToAnchor: self.containerView.leadingAnchor constant: 16]
    ]];
}

- (void) setupTitleLabel {
    CGFloat leadingAnchorValue = self.viewModel.type == NotificationTypeInfo ? 16 : 40;
    [self.containerView addSubview: self.titleLabel];
    self.titleLabel.text = self.viewModel.title;
    self.titleLabel.textColor = self.viewModel.textColor;
    self.titleLabel.font = [UIFont boldSystemFontOfSize: 16];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.titleLabel.topAnchor constraintEqualToAnchor: self.containerView.topAnchor constant: 16],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor: self.containerView.leadingAnchor constant: leadingAnchorValue],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor: self.containerView.trailingAnchor constant: -16]
    ]];
}

- (void) setupTextLabel {
    CGFloat leadingAnchorValue = self.viewModel.type == NotificationTypeInfo ? 16 : 40;
    [self.containerView addSubview: self.textLabel];
    self.textLabel.text = self.viewModel.text;
    self.textLabel.textColor = self.viewModel.textColor;
    self.textLabel.font = [UIFont systemFontOfSize: 16];
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints: @[
        [self.textLabel.topAnchor constraintEqualToAnchor: self.titleLabel.bottomAnchor constant: 8],
        [self.textLabel.bottomAnchor constraintEqualToAnchor: self.containerView.bottomAnchor constant: -16],
        [self.textLabel.leadingAnchor constraintEqualToAnchor: self.containerView.leadingAnchor constant: leadingAnchorValue],
        [self.textLabel.trailingAnchor constraintEqualToAnchor: self.containerView.trailingAnchor constant: -16]
    ]];
}

- (CGFloat) calculateMessageHeightWith: (NSString*) title text: (NSString*) text {
    NSAttributedString* titleString = [[NSAttributedString alloc] initWithString: title attributes: [NSDictionary dictionaryWithObject: [UIFont boldSystemFontOfSize: 16] forKey: NSFontAttributeName]];
    NSAttributedString* textString = [[NSAttributedString alloc] initWithString: text attributes: [NSDictionary dictionaryWithObject: [UIFont systemFontOfSize: 16] forKey: NSFontAttributeName]];
    CGRect titleRect = [titleString boundingRectWithSize: CGSizeZero options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesDeviceMetrics context: nil];
    CGRect textRect = [textString boundingRectWithSize: CGSizeZero options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesDeviceMetrics context: nil];
    return titleRect.size.height + textRect.size.height + 56;
}

- (CGRect) calculateFrameWith: (CGFloat) messageHeight {
    CGFloat height = self.window.safeAreaInsets.top + messageHeight;
    return CGRectMake(0, 0, self.windowWidth, height);
}


#pragma mark - Gestures

- (void) addTapGestureRecognizer {
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTap:)];
    [self.tapGesture setNumberOfTouchesRequired: 1];
    [self addGestureRecognizer: self.tapGesture];
}

- (void) handleTap: (UITapGestureRecognizer*) tapGestureRecognizer {
    if (self.viewModel.action != nil) {
        self.viewModel.action();
    }
    [self closeWithAnimation];
    [self.delegate notificationDidTap];
}

#pragma mark - Show / Close

- (void) showWithAnimation {
    [UIView animateWithDuration: 0.5
                     animations: ^{
        self.containerView.layer.opacity = 0.9;
        [self startTimer];
    } completion:^(BOOL finished) {
        if (self.delegate != nil) {
            [self.delegate notificationDidShow];
        }
    }];
}

- (void) closeWithAnimation {
    [UIView animateWithDuration: 0.5
                     animations:^{
        self.containerView.layer.opacity = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self removeGestureRecognizer: self.tapGesture];
        if (self.delegate != nil) {
            [self.delegate notificationDidClose];
        }
    }];
}

#pragma mark - Timers

- (void) startTimer {
    if (self.duration > 0) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 1
                                                  target: self
                                                selector: @selector(updateTimer:)
                                                userInfo: nil
                                                 repeats: YES];
}

- (void) updateTimer: (NSTimer*) sender {
    self.duration -= 1;
    if (self.duration <= 0) {
        [sender invalidate];
        if (self.delegate != nil) {
            [self.delegate notifictionWillClose: self];
        }
    }
}

@end

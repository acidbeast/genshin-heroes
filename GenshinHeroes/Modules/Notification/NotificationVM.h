//
//  NotificationVM.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/13/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NotificationType.h"
#import "NotificationModel.h"
#import "Blocks.h"
#import "Colors.h"

NS_ASSUME_NONNULL_BEGIN

@interface NotificationVM : NSObject

@property (strong, nonatomic) UIColor* backgroundColor;
@property (strong, nonatomic) UIColor* textColor;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSString* iconName;
@property (assign, nonatomic) NotificationType type;
@property (copy, nonatomic) EmptyBlock action;

- (instancetype) initWithType: (NotificationType) type
                        model: (NotificationModel*) model;

@end

NS_ASSUME_NONNULL_END

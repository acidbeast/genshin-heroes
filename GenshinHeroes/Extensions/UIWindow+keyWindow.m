//
//  UIWindow+keyWindow.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 4/27/23.
//

#import "UIWindow+keyWindow.h"

@implementation UIWindow(keyWindow)

+ (UIWindow*) keyWindow {
    NSArray<UIWindow *> *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        if (window.isKeyWindow) {
            return window;
        }
    }
    return nil;
}

@end

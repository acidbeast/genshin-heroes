//
//  AppDelegate.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 3/11/23.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end


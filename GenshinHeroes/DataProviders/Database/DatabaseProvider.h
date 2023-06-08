//
//  DatabaseProvider.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 6/5/23.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DatabaseProviderProtocol

@property (readonly, strong) NSPersistentContainer* persistentContainer;
- (void) saveContext;
- (NSPersistentContainer*) persistentContainer;

@end

@interface DatabaseProvider : NSObject

@property (readonly, strong) NSPersistentContainer* persistentContainer;

+ (instancetype) shared;

- (void) saveContext;
- (NSPersistentContainer*) persistentContainer;

@end

NS_ASSUME_NONNULL_END

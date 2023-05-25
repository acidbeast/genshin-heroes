//
//  HeroDetailsVM.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/19/23.
//

#import <Foundation/Foundation.h>
#import "CoreDataService.h"
#import "Character+CoreDataClass.h"
#import "DetailsSection.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DetailsVMDelegate

- (void) onFetchHeroLoading;
- (void) onFetchHeroSuccess;
- (void) onFetchHeroError: (NSError*) error;

@end

@interface DetailsVM : NSObject

@property (weak, nonatomic) id <DetailsVMDelegate> delegate;
@property (strong, nonatomic) NSString* heroName;
@property (strong, nonatomic) Character* hero;
@property (strong, nonatomic) NSMutableArray* sections;

- (instancetype) initWithHeroName: (NSString*) heroName
                  coreDataService: (CoreDataService*) coreDataService;

- (void) getHeroDetails;

@end

NS_ASSUME_NONNULL_END

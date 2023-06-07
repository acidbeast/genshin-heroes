//
//  DetailsSection.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/23/23.
//

#import <Foundation/Foundation.h>
#import "DetailsSectionType.h"

NS_ASSUME_NONNULL_BEGIN


@interface DetailsSection : NSObject

@property (assign, nonatomic) DetailsSectionType type;
@property (strong, nonatomic) NSString* _Nullable title;
@property (strong, nonatomic) NSString* _Nullable text;
@property (assign, nonatomic) NSInteger rating;
@property (strong, nonatomic) NSString* _Nullable imageName;
@property (strong, nonatomic) NSString* _Nullable value;
@property (assign, nonatomic) BOOL background;
@property (assign, nonatomic) BOOL isFavorite;

- (instancetype) initWithType: (DetailsSectionType) type title: (NSString*) title;
- (instancetype) initWithType: (DetailsSectionType) type text: (NSString*) text;
- (instancetype) initWithType: (DetailsSectionType) type rating: (NSInteger) rating;
- (instancetype) initWithType: (DetailsSectionType) type imageName: (NSString*) imageName isFavorite: (BOOL) isFavorite;
- (instancetype) initWithType: (DetailsSectionType) type title: (NSString*) title value: (NSString*) value background: (Boolean) background;

@end

NS_ASSUME_NONNULL_END

//
//  DetailsSection.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/23/23.
//

#import "DetailsSection.h"

@implementation DetailsSection

- (instancetype) initWithType: (DetailsSectionType) type title: (NSString*) title {
    self = [super init];
    if (self) {
        self.type = type;
        self.title = title;
    }
    return self;
}

- (instancetype) initWithType: (DetailsSectionType) type text: (NSString*) text {
    self = [super init];
    if (self) {
        self.type = type;
        self.text = text;
    }
    return self;
}

- (instancetype) initWithType: (DetailsSectionType) type rating: (NSInteger) rating {
    self = [super init];
    if (self) {
        self.type = type;
        self.rating = rating;
    }
    return self;
}

- (instancetype) initWithType: (DetailsSectionType) type imageName: (NSString*) imageName isFavorite: (BOOL) isFavorite {
    self = [super init];
    if (self) {
        self.type = type;
        self.imageName = imageName;
        self.isFavorite = isFavorite;
    }
    return self;
}

- (instancetype) initWithType: (DetailsSectionType) type title: (NSString*) title value: (NSString*) value background: (Boolean) background {
    self = [super init];
    if (self) {
        self.type = type;
        self.title = title;
        self.value = value;
        self.background = background;
    }
    return self;
}

@end

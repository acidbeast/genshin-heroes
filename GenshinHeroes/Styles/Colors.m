//
//  Colors.m
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/2/23.
//

#import "Colors.h"

@implementation Colors

- (instancetype) init {
    self = [super init];
    if (self) {
        [self initBackgroundColors];
        [self initTextColors];
        [self initVisionColors];
        [self initRarityColors];
        [self initFavoriteColors];
    }
    return self;
}

+ (instancetype) shared {
    static Colors* colors = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colors = [[Colors alloc] init];
    });
    return colors;
}

- (void) initBackgroundColors {
    self.background = @{
        @"primary": [UIColor colorWithHex: @"#ebeaef"]
    };
}

- (void) initTextColors {
    self.text = @{
        @"primary": [UIColor colorWithHex: @"#000000"],
        @"error": [UIColor colorWithHex: @"#c40000"]
    };
}

- (void) initVisionColors {
    self.vision = @{
        @"anemo": [UIColor colorWithHex: @"#7BC9AA"],
        @"cryo": [UIColor colorWithHex: @"#A0DBE5"],
        @"dendro": [UIColor colorWithHex: @"#B3D235"],
        @"electro": [UIColor colorWithHex: @"#B694C4"],
        @"geo": [UIColor colorWithHex: @"#F5B654"],
        @"hydro": [UIColor colorWithHex: @"#5CC0EA"],
        @"pyro": [UIColor colorWithHex: @"#F37F52"]
    };
}

- (void) initRarityColors {
    self.rarity = @{
        @"rarity4": [UIColor colorWithHex: @"#FAA922"],
        @"rarity5": [UIColor colorWithHex: @"#AC6BAD"]
    };
}

- (void) initFavoriteColors {
    self.favorite = @{
        @"primary": [UIColor lightGrayColor],
        @"selected": [UIColor redColor]
    };
}

@end

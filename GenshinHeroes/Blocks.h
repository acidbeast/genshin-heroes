//
//  Blocks.h
//  GenshinHeroes
//
//  Created by Dmitry Shlepkin on 5/18/23.
//

#import "Character+CoreDataClass.h"

#ifndef Blocks_h
#define Blocks_h

typedef void (^EmptyBlock)(void);
typedef void (^BlockWithError)(NSError* error);
typedef void (^BlockWithCharacter)(Character* character);
typedef void (^BlockWithCharactersList)(NSArray* characters);

#endif /* Blocks_h */

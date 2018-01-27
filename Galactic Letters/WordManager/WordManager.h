//
//  WordManager.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//


/** The word manager is responsible for keeping track of the letters the user has entered; if the user has entered a letter consistent with the spelling of the target word, then the user can continue to add additional letters to the cached word currently in progress; if the user has entered a letter inconsistent with target word spelling, the cached word is reset; the cached word matches the target word, the user has completed the level **/

#ifndef WordManager_h
#define WordManager_h

#import <Foundation/Foundation.h>
#import "WordManagerDataSource.h"
#import "WordManagerDelegate.h"

@interface WordManager: NSObject

-(instancetype)initWithTargetWord:(NSString*)targetWord;
-(instancetype)initWith:(id<WordManagerDataSource>)targetWordDataSource;

-(void)evaluateNextLetter:(char)nextLetter;

@property (readonly) NSString* targetWord;
@property (readonly) NSString* wordInProgress;

@property id<WordManagerDelegate> delegate;


@property (readonly) BOOL isAutomaticallyLooped;
@property (readonly) int totalPoints;


@end

#endif /* WordManager_h */

//
//  LetterManager.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#ifndef LetterManager_h
#define LetterManager_h

#import "WordManagerDelegate.h"

@interface LetterManager: NSObject 

@property NSString* targetWord;


-(instancetype)initWithSpawnPoints:(NSArray<NSValue*>*)spawnPoints andWithTargetWord:(NSString*)targetWord;

-(void)update:(NSTimeInterval)currentTime;

-(void)addLettersTo:(SKScene*)scene;
-(void)clearLetters;

-(void)handleContactForLetterWith:(NSString*)letterIdentifier andWithContactedObjectName:(NSString*)contactedObjectName;

@end

#endif /* LetterManager_h */

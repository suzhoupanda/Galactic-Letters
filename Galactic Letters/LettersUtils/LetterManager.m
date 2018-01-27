//
//  LetterManager.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import <UIKit/UIKit.h>
#import "RandomPointGenerator.h"
#import "LetterManager.h"
#import "Letter.h"
#import "LetterDelegate.h"

/** The letter manager spawns the letters for a given target word, adding them to the scene, and randomizes the positions of the letters at regular update intervals. It also handles some of the contact logic between letters and other game objects.  The letter manager is independent of the word manager, which manages the target word and word in progress.  However, the letter manager can implement the word manager delegate, in which case it can be notified when the target word is changed.  In this situation, it can add new letters to the scene automatically but would need to have a weak reference to the game scene  in order to add letters to the SKScene - The letter manager can take a reference to the scene, allowing it to add new letters when the target word is updated.
 
 As an alternative, and the one we've chosen here, the GameScene class itself can serve as the delegate for the word manager class, and when the target word is updated, the GameScene class is notified via the WordManager delegate methods.  When the target word is updated, messages can be sent to the letter manager, informing it that it needs to update its target word, and it can also be directed to add new letters to the scene **/

@interface LetterManager() <LetterDelegate>

@property NSMutableArray<Letter*>* letters;
@property NSArray<NSValue*>* spawnPoints;

@property NSTimeInterval repositionInterval;
@property NSTimeInterval frameCount;
@property NSTimeInterval lastUpdateTime;

@property BOOL lettersAreHidden;
@property RandomPointGenerator* pointGenerator;

@end


@implementation LetterManager



-(instancetype)initWithSpawnPoints:(NSArray<NSValue*>*)spawnPoints andWithTargetWord:(NSString*)targetWord{

    self = [super init];
    
    if(self){
        self.spawnPoints = spawnPoints;
        self.targetWord = targetWord;
        self.letters = [[NSMutableArray alloc] initWithCapacity:self.targetWord.length];
        self.lettersAreHidden = YES;
        self.pointGenerator = [[RandomPointGenerator alloc] init];
        
        self.frameCount = 0.00;
        self.repositionInterval = 4.00;
        self.lastUpdateTime = 0.00;
    }
    
    return self;

}

-(void)addLettersTo:(SKScene*)scene{
    
    for (int charIndex = 0; charIndex < self.targetWord.length; charIndex++) {
        
        char wordChar = [self.targetWord characterAtIndex:charIndex];
        
        Letter* newLetter = [[Letter alloc] initWithLetter:wordChar andWithWordIndex:charIndex];
        
        newLetter.delegate = self;
        
        CGPoint randomPos = [self getRandomSpawnPointPosition];
        
        [newLetter addLetterTo:scene atPosition:randomPos];
        
        [self.letters addObject:newLetter];
        
    }
}


-(void)update:(NSTimeInterval)currentTime{
    
    
    
    if(self.frameCount == currentTime){
        self.frameCount = 0;
    }
    
    
    self.frameCount += currentTime - self.lastUpdateTime;
    
    //Update all of the letters
    for (Letter*letter in self.letters) {
        
        [letter update:currentTime];
    }

    if(self.frameCount > self.repositionInterval){
        
        
        if(self.lettersAreHidden){
            
            [self revealLetters];
            
        } else {
        
            [self hideLetters];

        }
        
        self.frameCount = 0;
    }
    
    self.lastUpdateTime = currentTime;
}


-(void)revealLetters{
    
    for (Letter*letter in self.letters) {
        CGPoint randomOnScreenPos = [self getRandomOnScreenPosition];
        [letter setLetterPositionTo:randomOnScreenPos];
    }
    
    self.lettersAreHidden = NO;

}

-(void)hideLetters{
    for (Letter*letter in self.letters) {
        
        CGPoint randomPos = [self getRandomSpawnPointPosition];
        [letter setLetterPositionTo: randomPos];
        
    
    }
    self.lettersAreHidden = YES;
}

-(CGPoint)getRandomOnScreenPosition{
    
    return [self.pointGenerator getRandomOnScreenCoordinate];
}

-(CGPoint)getRandomSpawnPointPosition{
    
    NSUInteger randomIndex = arc4random_uniform((UInt32)self.spawnPoints.count);
    
    NSValue* positionVal = [self.spawnPoints objectAtIndex:randomIndex];
    
    return positionVal.CGPointValue;
}


/** The contacted letter can take different amounts of damage based on the enemy that contacts it **/

-(void)handleContactForLetterWith:(NSString*)letterIdentifier andWithContactedObjectName:(NSString*)contactedObjectName{
    
    NSLog(@"The letter identifiers is: %@",letterIdentifier);
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"identifier LIKE %@",letterIdentifier];
    
   Letter* contactedLetter = [[self.letters filteredArrayUsingPredicate:predicate] firstObject];
    
    NSString* contactedLetterInfo = [contactedLetter debugDescription];
    
    NSLog(@"Contacted letter info: %@",contactedLetterInfo);
    
    [contactedLetter takeDamage:1];
    

}

-(void)clearLetters{
    
  
    self.letters = nil;
    
    self.letters = [[NSMutableArray alloc] init];

}

/** Conformance to LetterDelgate protocol **/

-(void)didDestroyLetter:(Letter *)letter{
    
    [self.letters removeObject:letter];
}




@end

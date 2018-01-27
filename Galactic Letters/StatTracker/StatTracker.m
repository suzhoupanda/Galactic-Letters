//
//  StatTracker.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/26/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatTracker.h"
#import "Letter.h"

@interface StatTracker()

@end


@implementation StatTracker


-(instancetype)init{
    
    self = [super init];
    
    if(self){
        
        self.totalPointsAccumulated = 0;
        self.numberOfTargetWordsCompleted = 0;
        self.numberOfLettersSpelledCorrectly = 0;
        self.numberOfMisspellings = 0;
    }
    
    return self;
}

-(void)addPointsForTargetWord:(NSString*)targetWord{
    
    int additionalPoints = [self pointsForTargetWord:targetWord];
    
    self.totalPointsAccumulated += additionalPoints;
}


-(int)pointsForTargetWord:(NSString*)targetWord{
    
    int totalPoints = 0;
    
    for (NSUInteger charIndex = 0; charIndex < targetWord.length; charIndex++) {
        
        char wordChar = [targetWord characterAtIndex:charIndex];
        int pointsForChar = [Letter pointsForLetter:wordChar];
        totalPoints += pointsForChar;
        
    }
    
    return totalPoints;
}

-(int)spellingAccuracy{
    
    return (self.numberOfLettersSpelledCorrectly)/(self.numberOfLettersSpelledCorrectly + self.numberOfMisspellings);
}


@end

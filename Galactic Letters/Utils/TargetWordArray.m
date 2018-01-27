//
//  TargetWordArray.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/25/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TargetWordArray.h"

@interface TargetWordArray() 

@property NSArray<NSString*>* targetWords;
@property int currentTargetWordIndex;

@property (readonly) BOOL hasTargetWords;
@property BOOL hasCompletedIteration;

@end


@implementation TargetWordArray

-(instancetype)initDebugArray{
    
    NSArray<NSString*>* targetWords = @[
        @"JUSTICE",
        @"POETRY",
        @"PASSION",
        @"WAR",
        @"PEACE",
        @"GENIUS",
        @"GRAVITY"
        ];
    
    
    return [self initWith:targetWords];

}


-(instancetype)initWith:(NSArray<NSString*>*)targetWords{
    
    self = [super init];
    
    if(self){
        
        self.targetWords = targetWords;
        self.currentTargetWordIndex = 0;
        
        self.hasCompletedIteration = NO;

    }
    
    return self;
}

-(NSString *)getInitialTargetWord{
    
    if(!self.hasTargetWords){
        return nil;
    }
    
    return [self.targetWords firstObject];
}

-(NSString *)getNextTargetWord{
    
    if(!self.hasTargetWords){
        return nil;
    }
    
    if(self.currentTargetWordIndex < self.targetWords.count){
        
        self.currentTargetWordIndex += 1;

        NSString* nextWord = [self.targetWords objectAtIndex:self.currentTargetWordIndex];

        return nextWord;
        
    } else {
        
        if(!self.hasCompletedIteration){
            self.hasCompletedIteration = YES;
        }
        
        self.currentTargetWordIndex = 0;
        
        return [self getInitialTargetWord];
    }
    
}


-(BOOL)hasTargetWords{
    
    return self.targetWords.count > 0;
}

-(BOOL)hasAcquiredAllTargetWords{
    return self.hasCompletedIteration;
}

@end

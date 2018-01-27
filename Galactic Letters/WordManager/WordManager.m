//
//  WordManager.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/23/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordManager.h"
#import "Letter.h"
#import "Constants.h"

@interface WordManager()

@property (readwrite) NSString* targetWord;
@property (readwrite) NSString* wordInProgress;

@property id<WordManagerDataSource> dataSource;


@end

@implementation WordManager

-(instancetype)initWithTargetWord:(NSString *)targetWord{
    
    self = [super init];
    
    if(self){
        
        self.targetWord = targetWord;
        self.wordInProgress = [[NSString alloc] init];
        
    }
    
    return self;
}

-(instancetype)initWith:(id<WordManagerDataSource>)targetWordDataSource{
    
    self = [super init];
    
    if(self){
        
        self.dataSource = targetWordDataSource;
        self.targetWord = [self.dataSource getInitialTargetWord];
        self.wordInProgress = [[NSString alloc] init];
        
    }
    
    return self;
}

-(NSString*)getTargetWord{
    return self.targetWord;
}

-(NSString*)getWordInProgress{
    return self.wordInProgress;
}

-(void)evaluateNextLetter:(char)nextLetter{
    
    
    NSUInteger currentWordLength = self.wordInProgress.length;
    
    
    
    char nextTargetLetter = [self.targetWord characterAtIndex:currentWordLength];
    
    /**  If the next letter touched is the same as the next letter in the target word, add it to the cached word in progress **/
    if(nextLetter == nextTargetLetter){
        
   
        NSString* previousWordInProgress = self.wordInProgress;
        
        self.wordInProgress = [NSString stringWithFormat:@"%@%c",previousWordInProgress,nextLetter];
        
        [self.delegate didUpdateWordInProgress:self.wordInProgress];
        [self.delegate didExtendWordInProgress:self.wordInProgress];

      
        if(self.hasCompletedTargetWord){
            

            NSString* previousTargetWord = self.targetWord;
            [self acquireNextTargetWord];
            
            [self.delegate didUpdateTargetWordTo:self.targetWord fromPreviousTargetWord:previousTargetWord];
            
            
            NSString* deletedWordInProgress = self.wordInProgress;
            
            self.wordInProgress = [[NSString alloc] init];
            [self.delegate didClearWordInProgress:deletedWordInProgress];
            
        }
        
        

        
        /** If the next letter touched is not the same as the next letter in the target word, clear the word in progress; based on game rules, the user must start building the word again **/
    } else {
        

        NSString* deletedWordInProgress = self.wordInProgress;
        self.wordInProgress = [[NSString alloc] init];
        
        [self.delegate didMisspellWordInProgress:deletedWordInProgress];
        [self.delegate didClearWordInProgress:deletedWordInProgress];
        [self.delegate didUpdateWordInProgress:self.wordInProgress];
        
        }
        
    
    
}

-(BOOL)hasCompletedTargetWord{
    
    return self.wordInProgress.length == self.targetWord.length;
    
    
}


/** **/
-(void)acquireNextTargetWord{
    
    if([self.dataSource respondsToSelector:@selector(hasAcquiredAllTargetWords)] && [self.dataSource hasAcquiredAllTargetWords]){
        
        NSLog(@"All target words have been acquired...");
        
        /** Implement custom logic for cases where special rules apply if all the words provided by a data source have been provided  **/
    }
    
    self.targetWord = [self.dataSource getNextTargetWord];
}

-(void) showDebugMessageWith:(NSString*)text{
    if(kDebugWordManager){
        NSLog(text);
        
    }
}




@end

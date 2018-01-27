//
//  HUDManager.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/26/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HUDManager.h"


@interface HUDManager()

@property SKNode* scoreNode;
@property SKNode* targetWordNode;
@property SKNode* wordInProgressNode;

@property SKLabelNode* scoreLabel;
@property SKLabelNode* targetWordLabel;
@property SKLabelNode* wordInProgressLabel;

@property (readonly) NSNumberFormatter* scoreFormatter;

@end


@implementation HUDManager

-(instancetype)init{
    
    self = [super init];
    
    
    if(self){
        [self setupHUDNodes];
    }
    
    return self;
}

-(instancetype)initWithTargetWord:(NSString*)targetWord{
    
    self = [super init];
    
    if(self){
        
        [self setupHUDNodes];
        
        [self updateTargetWordNode:targetWord];
        [self updateWordInProgressNode:@""];
        [self updateScoreNode:0];
    }
    
    return self;
}

-(void)setupHUDNodes{
    
    self.scoreNode = [[SKNode alloc] init];
    self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
    [self.scoreLabel moveToParent:self.scoreNode];
    [self.scoreLabel setPosition:CGPointMake(0.0, 200.0)];
    [self.scoreLabel setFontColor:[UIColor whiteColor]];
    [self.scoreLabel setFontSize:30.0];
    
    self.targetWordNode = [[SKNode alloc] init];
    self.targetWordLabel = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
    [self.targetWordLabel moveToParent:self.targetWordNode];
    [self.targetWordLabel setPosition:CGPointMake(0.0, -250.0)];
    [self.targetWordLabel setColor:[UIColor whiteColor]];
    [self.targetWordLabel setFontSize:20.0];
    
    self.wordInProgressNode = [[SKNode alloc] init];
    self.wordInProgressLabel = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
    [self.wordInProgressLabel moveToParent:self.wordInProgressNode];
    [self.wordInProgressLabel setPosition:CGPointMake(0.0, -200.0)];
    [self.wordInProgressLabel setColor:[UIColor whiteColor]];
    [self.wordInProgressLabel setFontSize:20.0];
    
}

-(void)addHUDNodeTo:(SKScene*)scene atPosition:(CGPoint)position{
    
    [self.targetWordNode moveToParent:scene];
    [self.wordInProgressNode moveToParent:scene];
    [self.scoreNode moveToParent:scene];
    
}

-(void)updateScoreNode:(int)updatedScore{
    
    NSString* scoreString = [self.scoreFormatter stringFromNumber:[NSNumber numberWithInteger:updatedScore]];
    
    [self.scoreLabel setText:scoreString];
    
}

-(void)updateTargetWordNode:(NSString*)updatedTargetWord{
    
    [self.targetWordLabel setText:updatedTargetWord];
}

-(void)updateWordInProgressNode:(NSString*)updatedWordInProgress{
    
    [self.wordInProgressLabel setText:updatedWordInProgress];
}

-(NSNumberFormatter *)scoreFormatter{
    
    NSNumberFormatter* scoreFormatter = [[NSNumberFormatter alloc] init];
    
    [scoreFormatter setMinimum:[NSNumber numberWithInteger:4]];
    [scoreFormatter setMaximum:[NSNumber numberWithInteger:4]];
    [scoreFormatter setMaximumFractionDigits:[NSNumber numberWithInteger:0]];
    [scoreFormatter setMaximumIntegerDigits:4];
    
    return scoreFormatter;
}



@end

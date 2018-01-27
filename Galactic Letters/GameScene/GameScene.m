//
//  GameScene.m
//  Galactic Letters
//
//  Created by Aleksander Makedonski on 1/27/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import "GameScene.h"
#import "RandomPointGenerator.h"
#import "Constants.h"
#import "LetterManager.h"
#import "WordManager.h"
#import "TargetWordArray.h"
#import "StatTracker.h"
#import "HUDManager.h"
#import "Cloud.h"

@interface GameScene() <SKPhysicsContactDelegate,WordManagerDelegate>

@property NSArray<NSValue*>*randomSpawnPoints;
@property LetterManager* letterManager;
@property NSString* targetWord;

@property WordManager* wordManager;
@property TargetWordArray* debugTargetWordArray;
@property StatTracker* statTracker;
@property HUDManager* hudManager;

@end


@implementation GameScene

const static CGFloat kHUDXPosition = 0.0;
const static CGFloat kHUDYPosition = 0.0;


- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    [self configureScene];
    [self setupBackground];
    [self setupBGMusic];
    [self setupSpawnPoints];
    [self setupStatTracker];
    [self setupWordManager];
    [self acquireTargetWord];
    [self setupHUDManager];
    [self setupLetterManager];
    [self createClouds];
    [self addTargetWordLetters];
    
    
}

//MARK: ********** Helper Functions For Setting Up the Gameplay

-(void)configureScene{
    self.physicsWorld.contactDelegate = self;
    self.anchorPoint = CGPointMake(0.5, 0.5);
}

-(void)setupBackground{
    
    SKEmitterNode* starEmitter = [SKEmitterNode nodeWithFileNamed:@"stars"];
    [self addChild:starEmitter];
    starEmitter.position = CGPointZero;
}


-(void)setupBGMusic{
    SKAudioNode* bgNode = [SKAudioNode nodeWithFileNamed:@"Mishief-Stroll.mp3"];
    
    if(bgNode){
        [self addChild:bgNode];
        
    }
}


-(void)setupSpawnPoints{
    
    RandomPointGenerator* pointGen = [[RandomPointGenerator alloc] init];
    int numPoints = kNumberOfOnScreenDebugPoints;
    self.randomSpawnPoints = [pointGen getArrayOfOnScreenPoints: numPoints];

    
}

-(void)setupStatTracker{
    
    self.statTracker = [[StatTracker alloc] init];
}

-(void)setupWordManager{
    
    self.debugTargetWordArray = [[TargetWordArray alloc] initDebugArray];
    
    self.wordManager = [[WordManager alloc] initWith:self.debugTargetWordArray];
    
    self.wordManager.delegate = self;
    
    
}

-(void)acquireTargetWord{
    
    self.targetWord = [self.wordManager targetWord];
}


-(void)setupHUDManager{
    
    self.hudManager = [[HUDManager alloc] initWithTargetWord:self.targetWord];
    
    [self.hudManager addHUDNodeTo:self atPosition:CGPointMake(kHUDXPosition, kHUDYPosition)];
    
}



-(void)setupLetterManager{
    
    self.letterManager = [[LetterManager alloc] initWithSpawnPoints:self.randomSpawnPoints andWithTargetWord:self.targetWord];
    
}


-(void)createClouds{
    
    
    
    for (NSValue*pointVal in self.randomSpawnPoints) {
        
        Cloud* randomCloud = [Cloud getRandomCloud];
        [randomCloud addSpriteTo:self atPosition:pointVal.CGPointValue];
    }
}

-(void)addTargetWordLetters{
    
    if([self.letterManager targetWord]){
        [self.letterManager addLettersTo:self];
    }
    
}

//MARK: *********** Touch Handler Functions

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *t in touches) {
        
        
        CGPoint touchPoint = [t locationInNode:self];
        
        SKSpriteNode* node = (SKSpriteNode*)[self nodeAtPoint:touchPoint];
        
        if(node && [node.name containsString:@"letter"]){
            NSString* nodeName = node.name;
            
            char lastChar = [nodeName characterAtIndex:nodeName.length-1];
            
            NSLog(@"You touched the letter %c", lastChar);
            
            [self.wordManager evaluateNextLetter:lastChar];
            
        }
        
    }

}


//MARK: ************* Game Loop Functions

-(void)update:(CFTimeInterval)currentTime {
    
    if(self.letterManager){
        
        [self.letterManager update:currentTime];
        
    }
}


/** Word Manager delegate methods **/

-(void)didUpdateWordInProgress:(NSString *)wordInProgress{
    NSLog(@"The word in progress has been updated - the current word in progress is now: %@", wordInProgress);
    
    [self.hudManager updateWordInProgressNode:wordInProgress];
}

-(void)didClearWordInProgress:(NSString *)deletedWordInProgress{
    
    NSLog(@"The word in progress %@ has been cleared.  You must start over in order to spell the target word",deletedWordInProgress);
    
    [self.hudManager updateWordInProgressNode:@""];
}

-(void)didMisspellWordInProgress:(NSString*)misspelledWordInProgress{
    
    self.statTracker.numberOfMisspellings += 1;
    
}


-(void)didCompleteWordInProgress:(NSString *)completedWordInProgress{
    
    NSLog(@"The user has completed the word in progress: %@",completedWordInProgress);
    
    
}

-(void)didUpdateTargetWordTo:(NSString*)updatedTargetWord fromPreviousTargetWord:(NSString*)previousTargetWord{
    
    NSLog(@"The target word has been updated.  The new target word is: %@",updatedTargetWord);
    
    self.statTracker.numberOfTargetWordsCompleted += 1;
    [self.statTracker addPointsForTargetWord:previousTargetWord];
    
    [self.hudManager updateTargetWordNode:updatedTargetWord];
    [self.hudManager updateScoreNode:self.statTracker.totalPointsAccumulated];
    
    
    /** Acquire the next target word form the WordManager **/
    [self acquireTargetWord];
    
    
    /** Remove letter nodes from the scene **/
    [self removeLetterNodes];
    
    /** Clear all the letters currently managed by the LetterManager **/
    [self.letterManager clearLetters];
    
    /** Reset the target word for the letter manager **/
    [self.letterManager setTargetWord:self.targetWord];
    
    /** Add the new letters from the letter manager to the scene **/
    [self.letterManager addLettersTo:self];
}

-(void)didExtendWordInProgress:(NSString*)extendedWordInProgress{
    
    self.statTracker.numberOfLettersSpelledCorrectly += 1;
    
}

//MARK: ******* Helper Function for Removing Excess Letters

-(void)removeLetterNodes{
    for (SKSpriteNode* node in self.children) {
        if([node.name containsString:@"letter"]){
            [node removeFromParent];
        }
    }
}


@end

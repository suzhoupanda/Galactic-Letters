//
//  Letter.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Letter.h"
#import "ContactBitMasks.h"
#import "Constants.h"

@interface Letter()

@property SKSpriteNode* sprite;
@property int health;
@property NSUInteger wordIndex;
@property char letterChar;

@property BOOL isRecovering;
@property NSTimeInterval recoveryInterval;
@property NSTimeInterval frameCount;
@property NSTimeInterval lastUpdateTime;

@end

@implementation Letter

const static double recoveryTime = 0.60;


-(instancetype)initWithLetter:(char)letter{
    
    self = [self initWithLetter:letter andWithWordIndex:0];
    
    return self;
}

-(instancetype)initWithLetter:(char)letter andWithWordIndex:(NSUInteger)wordIndex{
    
    self = [self initWithLetter:letter andWithStartingHealth:3 andWithWordIndex:wordIndex];
    
    return self;
}

-(instancetype)initWithLetter:(char)letter andWithStartingHealth: (int)startingHealth andWithWordIndex:(NSUInteger)wordIndex{

    self = [super init];
    
    if(self){
        
        letter = toupper(letter);
        
        self.letterChar = letter;
        self.health = startingHealth;
        self.wordIndex = wordIndex;
        self.isRecovering = NO;
        self.frameCount = 0.00;
        self.recoveryInterval = recoveryTime;
        
        NSString* spriteName = [NSString stringWithFormat:@"letter_%c",letter];

        SKTexture* letterTexture = [SKTexture textureWithImageNamed:spriteName];
        
        self.sprite = [SKSpriteNode spriteNodeWithTexture:letterTexture];
        
        
        [self configureSpriteWithNodeName:spriteName];
        
        [self configurePhysicsProperties:letterTexture];
        
    }
    
    return self;
}

-(NSString *)identifier{
    return self.sprite.name;
}

-(void)configurePhysicsProperties:(SKTexture*)letterTexture{
    
    CGSize textureSize = [letterTexture size];
    
    self.sprite.physicsBody = [SKPhysicsBody bodyWithTexture:letterTexture size:textureSize];

    self.sprite.physicsBody.affectedByGravity = NO;
    self.sprite.physicsBody.allowsRotation = NO;
    
    self.sprite.physicsBody.categoryBitMask = (UInt32)TD_LETTER;
    self.sprite.physicsBody.collisionBitMask = 0;
    self.sprite.physicsBody.contactTestBitMask = (UInt32)TD_PLAYER;
    
    
    

    
}

-(void)configureSpriteWithNodeName:(NSString*)spriteName{
    self.sprite.anchorPoint = CGPointMake(0.5, 0.5);
    self.sprite.xScale *= 0.2;
    self.sprite.yScale *= 0.2;
    self.sprite.name = [NSString stringWithFormat:@"%lu%@",(unsigned long)self.wordIndex,spriteName];
}

-(void)addLetterTo:(SKScene*)scene atPosition:(CGPoint)position{
    
    [self.sprite moveToParent:scene];
    [self.sprite setZPosition:kZPositionLetter];
    [self.sprite setPosition:position];
}

-(void)setLetterPositionTo:(CGPoint)position{
    
    SKAction* moveAction = [SKAction moveTo:position duration:0.5];
    [self.sprite runAction:moveAction];
    
}

-(void)takeDamage:(int)damageAmount{
    
    if(self.isRecovering){
        NSLog(@"Letter is recovering...");
        return;
    }
    
    NSLog(@"Letter is taking damage...");
    
    self.health -= damageAmount;
    
    
    switch (self.health) {
        case 3:
            [self runDamageAnimation];
            break;
        case 2:
            [self runDamageAnimation];
            break;
        case 1:
            [self runDamageAnimation];
            break;
        case 0:
            [self die];
            
            break;
        default:
            break;
    }
    
   
    
}


-(void)removeLetter{
    [self.sprite removeFromParent];
    [self.delegate didDestroyLetter:self];

}

-(void)runDamageAnimation{
    NSLog(@"Letter has been damaged...");
    
    SKAction* fadeAction = [SKAction fadeAlphaBy:0.20 duration:0.10];
    
    [self.sprite runAction:fadeAction];
}



-(void)die{
    NSLog(@"Letter is dead...");

    [self.sprite removeFromParent];
    [self.delegate didDestroyLetter:self];

}

+(int)pointsForLetter:(char)wordChar{
    
    switch (wordChar) {
        case 'A':
            return 1;
        case 'B':
            return 3;
        case 'C':
            return 3;
        case 'D':
            return 2;
        case 'E':
            return 1;
        case 'F':
            return 4;
        case 'G':
            return 2;
        case 'H':
            return 4;
        case 'I':
            return 1;
        case 'J':
            return 5;
        case 'K':
            return 8;
        case 'L':
            return 1;
        case 'M':
            return 3;
        case 'N':
            return 1;
        case 'O':
            return 1;
        case 'P':
            return 3;
        case 'Q':
            return 1;
        case 'R':
            return 1;
        case 'S':
            return 1;
        case 'T':
            return 1;
        case 'U':
            return 1;
        case 'V':
            return 4;
        case 'W':
            return 4;
        case 'X':
            return 8;
        case 'Y':
            return 4;
        case 'Z':
            return 10;
        default:
            return 1;
    }
}





-(int)pointValue{
    return [Letter pointsForLetter:self.letterChar];
}

-(void)update:(NSTimeInterval)currentTime{
    
    if(currentTime == 0){
        self.frameCount = currentTime;
    }
    
    self.frameCount += currentTime - self.lastUpdateTime;
    
    if(self.frameCount > self.recoveryInterval){
        
        self.isRecovering = !self.isRecovering;
        
        self.frameCount = 0.00;
    }
    
    self.lastUpdateTime = currentTime;
    
}



@end

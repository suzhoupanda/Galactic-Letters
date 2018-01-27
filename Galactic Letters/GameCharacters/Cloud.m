//
//  Cloud.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Cloud.h"
#import "Constants.h"

@interface Cloud()

@property SKSpriteNode* sprite;

@end


@implementation Cloud

+(Cloud *)getRandomCloud{
    
    CloudType randomCloudType = (CloudType)(arc4random_uniform((UInt32)kNumberOfClouds)+1);
           
    return [[Cloud alloc] initWithCloudType:randomCloudType];
}

-(instancetype)initWithCloudType:(CloudType)cloudType{
    
    self = [super init];
    
    if(self){
        
        NSString* spriteName = [Cloud getCloudImageNameFor:cloudType];
        self.sprite = [SKSpriteNode spriteNodeWithImageNamed:spriteName];
        [self configureSprite];
    }
    
    return self;
}

-(void)configureSprite{
    
    self.sprite.anchorPoint = CGPointMake(0.5, 0.5);
    self.sprite.name = @"cloud";
    self.sprite.xScale *= 0.30;
    self.sprite.yScale *= 0.30;
    
}

-(void)addSpriteTo:(SKScene*)scene atPosition:(CGPoint)position{
    
    [self.sprite moveToParent:scene];
    
    [self.sprite setPosition:position];
    
    [self.sprite setZPosition:kZPositionCloud];
    
}

+(NSString*) getCloudImageNameFor:(CloudType)cloudType{
    
    return [NSString stringWithFormat:@"cloud%d",(int)cloudType];
}

@end

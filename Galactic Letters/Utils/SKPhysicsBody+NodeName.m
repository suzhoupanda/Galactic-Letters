//
//  SKPhysicsBody+NodeName.m
//  Galactic Letters
//
//  Created by Aleksander Makedonski on 1/27/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import "SKPhysicsBody+NodeName.h"
#import "Constants.h"

@implementation SKPhysicsBody (NodeName)


+(char)getLetterCharacterFromPhysicsBody:(SKPhysicsBody*)physicsBody{
    
    SKNode* node = [physicsBody node];
    
    if(!node){
        return kNoLetterCharacterAssociatedWithPhysicsBody;
    }
    
    
    NSString* nodeName = node.name;
    
    if(!nodeName){
        return kNoLetterCharacterAssociatedWithPhysicsBody;
    }
    
    char letterChar = [nodeName characterAtIndex:nodeName.length-1];
    
    if(!isalpha(letterChar)){
        return kNoLetterCharacterAssociatedWithPhysicsBody;
    }
    
    return letterChar;
    
}


@end

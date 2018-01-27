//
//  Cloud.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#ifndef Cloud_h
#define Cloud_h

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Cloud: NSObject

typedef enum{
    CloudType1 = 0,
    CloudType2,
    CloudType3,
    CloudType4,
    CloudType5,
    CloudType6,
    CloudType7,
    CloudType8,
    CloudType9,
} CloudType;

-(instancetype)initWithCloudType:(CloudType)cloudType;
-(void)addSpriteTo:(SKScene*)scene atPosition:(CGPoint)position;
+(Cloud*)getRandomCloud;

@end

#endif /* Cloud_h */

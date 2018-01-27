//
//  Constants.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"



 CGFloat kDebugSpawnAreaWidth = 600.0;
 CGFloat kDebugSpawnAreaHeight = 600.0;
 CGFloat kDebugSpawnArea_UpperY = 300.0;
 CGFloat kDebugSpawnArea_LowerY = -300.0;
 CGFloat kDebugSpawnArea_LowerX = -250.0;
 CGFloat kDebugSpawnArea_UpperX = 250.0;

int kNumberOfOnScreenDebugPoints = 5;
int kNumberOfClouds = 9;

char kNoLetterCharacterAssociatedWithPhysicsBody = '/';

CGFloat kCameraYOffsetTopDownPlane = 200.0;

/** Collision and Contact Bitmasks **/

 const UInt32 kLetterCategoryBitMask = 0;
 const UInt32 kEnemyCategoryBitMask = 1;

/** Z-Positions **/

 CGFloat kZPositionCloud = 5;
 CGFloat kZPositionSpikeman = 6;
 CGFloat kZPositionLetter = 3;

 CGFloat kZPositionTopDownPlane = 3;
 CGFloat kZPositionMissileLauncher = 3;


 BOOL kDebugWordManager = YES;



//
//  Constants.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef Constants_h

#define Constants_h




extern CGFloat kDebugSpawnAreaWidth;
extern CGFloat kDebugSpawnAreaHeight;
extern CGFloat kDebugSpawnArea_UpperY;
extern CGFloat kDebugSpawnArea_LowerY;
extern CGFloat kDebugSpawnArea_LowerX;
extern CGFloat kDebugSpawnArea_UpperX;

extern int kNumberOfOnScreenDebugPoints;
extern CGFloat kCameraYOffsetTopDownPlane;

extern char kNoLetterCharacterAssociatedWithPhysicsBody;


extern CGFloat kZPositionCloud;
extern CGFloat kZPositionLetter;
extern CGFloat kZPositionSpikeman;
extern CGFloat kZPositionTopDownPlane;
extern CGFloat kZPositionMissileLauncher;


extern int kNumberOfClouds;

extern BOOL kDebugWordManager;

extern const UInt32 kLetterCategoryBitMask;
extern const UInt32 kEnemyCategoryBitMask;

#endif /* Constants_h */

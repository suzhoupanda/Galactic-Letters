//
//  HUDManager.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/26/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#ifndef HUDManager_h
#define HUDManager_h

@import Foundation;
@import SpriteKit;

@interface HUDManager: NSObject

-(instancetype)init;
-(instancetype)initWithTargetWord:(NSString*)targetWord;
-(void)addHUDNodeTo:(SKScene*)scene atPosition:(CGPoint)position;
-(void)updateScoreNode:(int)updatedScore;
-(void)updateTargetWordNode:(NSString*)updatedTargetWord;
-(void)updateWordInProgressNode:(NSString*)updatedWordInProgress;

@end

#endif /* HUDManager_h */

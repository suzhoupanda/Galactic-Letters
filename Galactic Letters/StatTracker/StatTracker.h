//
//  StatTracker.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/26/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

/** The StatTracker keeps track of the number of spell attempts made, number of target words completed, and the total points accumulated **/

#ifndef StatTracker_h
#define StatTracker_h

@import Foundation;

@interface StatTracker: NSObject

@property int numberOfTargetWordsCompleted;
@property int numberOfMisspellings;
@property int totalPointsAccumulated;
@property int numberOfLettersSpelledCorrectly;
@property (readonly) double spellingAccuracy;

-(instancetype)init;
-(void)addPointsForTargetWord:(NSString*)targetWord;


@end

#endif /* StatTracker_h */

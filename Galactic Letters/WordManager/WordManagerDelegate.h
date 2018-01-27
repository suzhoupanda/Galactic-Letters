//
//  WordManagerDelegate.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/25/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>

/** The WordManager will inform its delegate when it has updated the word in progress;  it will also inform its delegate when it has cleared or completed its word in progress, as well as when it has updated the target word and when the user has earned points **/

@protocol WordManagerDelegate <NSObject>


-(void)didUpdateWordInProgress:(NSString*)wordInProgress;


@optional

-(void)didExtendWordInProgress:(NSString*)extendedWordInProgress;

-(void)didMisspellWordInProgress:(NSString*)misspelledWordInProgress;

-(void)didClearWordInProgress:(NSString*)deletedWordInProgress;

-(void)didCompleteWordInProgress:(NSString*)completedWordInProgress;

-(void)didEarnPoints:(int)totalPoints forTargetWord:(NSString*)targetWord;

-(void)didUpdateTargetWordTo:(NSString*)updatedTargetWord fromPreviousTargetWord:(NSString*)previousTargetWord;




@end

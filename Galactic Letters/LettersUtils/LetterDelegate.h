//
//  LetterDelegate.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/23/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Letter;

@protocol LetterDelegate <NSObject>


@optional

-(void)didDamageLetter:(Letter*)letter;

@required

-(void)didDestroyLetter:(Letter*)letter;

@end


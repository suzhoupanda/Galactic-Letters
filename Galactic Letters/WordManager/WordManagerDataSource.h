//
//  WordManagerDataSource.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/24/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WordManagerDataSource <NSObject>

-(NSString*)getInitialTargetWord;

-(NSString*)getNextTargetWord;

@optional

-(BOOL)hasAcquiredAllTargetWords;


@end

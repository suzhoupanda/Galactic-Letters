//
//  TargetWordArray.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/25/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordManagerDataSource.h"

@interface TargetWordArray: NSObject <WordManagerDataSource>

-(instancetype)initDebugArray;
-(instancetype)initWith:(NSArray<NSString*>*)targetWords;


@end

//
//  ScreenConstantGenerator.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#ifndef ScreenConstantGenerator_h
#define ScreenConstantGenerator_h

#import <Foundation/Foundation.h>

@interface RandomPointGenerator : NSObject

-(instancetype)init;
-(instancetype)initForDebugSpawnArea;

-(CGPoint)getRandomOnScreenCoordinate;
-(NSArray<NSValue*>*)getArrayOfOnScreenPoints:(NSInteger)numberOfPoints;

@end

#endif /* ScreenConstantGenerator_h */

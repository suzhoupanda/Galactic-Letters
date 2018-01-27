//
//  ScreenConstantGenerator.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameplayKit/GameplayKit.h>
#import "RandomPointGenerator.h"
#import "ScreenConstants.h"
#import "Constants.h"

@interface RandomPointGenerator()

@property GKMersenneTwisterRandomSource* randomXSource;
@property GKMersenneTwisterRandomSource* randomYSource;

@property GKRandomDistribution* randomXDist;
@property GKRandomDistribution* randomYDist;

@end



@implementation RandomPointGenerator


-(NSArray<NSValue*>*)getArrayOfOnScreenPoints:(NSInteger)numberOfPoints{
    
    NSMutableArray<NSValue*>* pointArray = [NSMutableArray arrayWithCapacity:numberOfPoints];
    
    for (int i = 0; i < numberOfPoints; i++) {
        
        CGPoint randomPoint = [self getRandomOnScreenCoordinate];
        
        NSValue* randomPointVal = [NSValue valueWithCGPoint:randomPoint];
        
        [pointArray addObject:randomPointVal];
        
    }
    
    return [NSArray arrayWithArray:pointArray];
}

-(CGPoint)getRandomOnScreenCoordinate{
    
    NSInteger xCoord = [self getRandomOnScreenXCoord];
    NSInteger yCoord = [self getRandomOnScreenYCoord];
    
    return CGPointMake(xCoord, yCoord);
}

-(NSInteger)getRandomOnScreenXCoord{
    return [self.randomXDist nextInt];
}

-(NSInteger)getRandomOnScreenYCoord{
    return [self.randomYDist nextInt];
}


-(instancetype)initForDebugSpawnArea{
    
    self = [super init];
    
    if(self){
        _randomXSource = [[GKMersenneTwisterRandomSource alloc] init];
        _randomYSource = [[GKMersenneTwisterRandomSource alloc] init];
        
        int lowestValX = kDebugSpawnArea_LowerX;
        int highestValX = kDebugSpawnArea_UpperX;
        
        int lowestValY = kDebugSpawnArea_LowerY;
        int highestValY = kDebugSpawnArea_UpperY;
        
        self.randomXDist = [[GKRandomDistribution alloc] initWithRandomSource:_randomXSource lowestValue:lowestValX highestValue:highestValX];
        
        self.randomYDist = [[GKRandomDistribution alloc] initWithRandomSource:_randomYSource lowestValue:lowestValY highestValue:highestValY];
        
    }
    
    return self;
}

-(instancetype)init{
    
    self = [super init];
    
    if(self){
        
        _randomXSource = [[GKMersenneTwisterRandomSource alloc] init];
        _randomYSource = [[GKMersenneTwisterRandomSource alloc] init];

        int lowestValX = (int)kLeftXBoundary;
        int highestValX = (int)kRightXBoundary;
        
        int lowestValY = (int)kLowerYBoundary;
        int highestValY = (int)kUpperYBoundary;
        
        self.randomXDist = [[GKRandomDistribution alloc] initWithRandomSource:_randomXSource lowestValue:lowestValX highestValue:highestValX];
        
        self.randomYDist = [[GKRandomDistribution alloc] initWithRandomSource:_randomYSource lowestValue:lowestValY highestValue:highestValY];

    }
    
    return self;
}

@end

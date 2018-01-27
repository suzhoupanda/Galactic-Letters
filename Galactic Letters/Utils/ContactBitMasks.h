//
//  ContactBitMasks.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/23/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#ifndef ContactBitMasks_h
#define ContactBitMasks_h

typedef enum{
    PLAYER = 0,
    ENEMY = 1,
    LETTER = 2,
    MISSILE = 4,
    MISSILE_LAUNCHER_DETECTION_NODE = 16
    
}SpaceShooterContactBitmasks;

typedef enum{
    TD_PLAYER = 0,
    TD_ENEMY = 1,
    TD_LETTER = 2,
    TD_MISSILE = 4,
    TD_MISSILE_LAUNCHER_DETECTION_NODE = 8,
    TD_GROUND = 16
}TopDownGameContactBitmasks;

#endif /* ContactBitMasks_h */

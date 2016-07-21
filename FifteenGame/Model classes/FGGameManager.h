//
//  FGGameManager.h
//  FifteenGame
//
//  Created by Aleksandr Smirnov on 18/07/16.
//  Copyright © 2016 Aleksandr Smirnov. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSInteger const kSide = 4; //размерность игрового поля
static NSInteger const kVoidValidX = 3;//координаты "пустышки" в финишной позиции
static NSInteger const kVoidValidY = 3;

@interface FGGameManager : NSObject

+(instancetype)sharedInstance;

-(NSMutableArray *)getValidPosition;

@end

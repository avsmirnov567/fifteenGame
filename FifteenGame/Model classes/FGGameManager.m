//
//  FGGameManager.m
//  FifteenGame
//
//  Created by Aleksandr Smirnov on 18/07/16.
//  Copyright © 2016 Aleksandr Smirnov. All rights reserved.
//

#import "FGGameManager.h"



@implementation FGGameManager

+(instancetype)sharedInstance{
    
    static FGGameManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [FGGameManager new];
    });
    return instance;
}

-(NSMutableArray *)getValidPosition{

    NSMutableArray *position = [[NSMutableArray alloc] initWithCapacity:4];
    [position insertObject:[NSMutableArray arrayWithObjects: @1,@5,@9,@13, nil] atIndex:0];
    [position insertObject:[NSMutableArray arrayWithObjects: @2,@6,@10,@14, nil] atIndex:1];
    [position insertObject:[NSMutableArray arrayWithObjects: @3,@7,@11,@15, nil] atIndex:2];
    [position insertObject:[NSMutableArray arrayWithObjects: @4,@8,@12,@0, nil] atIndex:3];
    return position;
}

@end

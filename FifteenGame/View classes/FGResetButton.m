//
//  FGResetButton.m
//  FifteenGame
//
//  Created by Aleksandr Smirnov on 22/07/16.
//  Copyright © 2016 Aleksandr Smirnov. All rights reserved.
//

#import "FGResetButton.h"

@implementation FGResetButton

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:8];
    [[UIColor yellowColor] setFill];
    [path fill];
}


@end

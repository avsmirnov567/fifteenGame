//
//  FGButton.h
//  FifteenGame
//
//  Created by Aleksandr Smirnov on 19/07/16.
//  Copyright © 2016 Aleksandr Smirnov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGFieldView.h"

@interface FGButton : UIButton

@property (nonatomic) NSInteger number;
@property (nonatomic) BOOL isUpperVoid;
@property (nonatomic) BOOL isLowerVoid;
@property (nonatomic) BOOL isOnRightFromVoid;
@property (nonatomic) BOOL isOnLeftFromVoid;
@property (nonatomic, weak) FGFieldView *field;

-(BOOL)isClickable;
-(void)clearClickability;
-(void)moveUp;
-(void)moveDown;
-(void)moveRight;
-(void)moveLeft;

+(instancetype)initWithNumber:(NSInteger)number andField:(FGFieldView *)field;


@end

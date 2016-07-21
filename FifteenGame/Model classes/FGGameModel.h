//
//  FGGameModel.h
//  FifteenGame
//
//  Created by Aleksandr Smirnov on 18/07/16.
//  Copyright © 2016 Aleksandr Smirnov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FGGameModel : NSObject

@property (nonatomic, strong) NSMutableArray *field;
@property (nonatomic) NSInteger voidX;
@property (nonatomic) NSInteger voidY;

-(instancetype)initWithValidPosition: (NSMutableArray *)validPosition;
-(void)makeStartPosition;

-(void)moveVoidUp;
-(void)moveVoidDown;
-(void)moveVoidRight;
-(void)moveVoidLeft;

-(void)moveColumnUp;
-(void)moveColumnDown;
-(void)moveStringRight;
-(void)moveStringLeft;

@end

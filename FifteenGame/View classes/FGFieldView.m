//
//  FGFieldView.m
//  FifteenGame
//
//  Created by Aleksandr Smirnov on 19/07/16.
//  Copyright © 2016 Aleksandr Smirnov. All rights reserved.
//

#import "FGFieldView.h"
#import "FGButton.h"
#import "FGGameManager.h"

IB_DESIGNABLE
@interface FGFieldView()


@property (nonatomic, strong) NSMutableDictionary *buttons;
@property (nonatomic) IBInspectable UIColor *fieldColor;

@end

@implementation FGFieldView

-(void)initModelWithStartPosition{
    self.model = [[FGGameModel alloc] initWithValidPosition:[[FGGameManager sharedInstance] getValidPosition]];
    [self.model makeStartPosition];
}

-(void)makeButtonsClickable{
    [self clearButtonsClickability];
    for(int i=0;i<self.model.field.count; i++){
        for(int j=0; j<self.model.field.count; j++){
            if([self.model.field[i][j] isEqual:@0]){
                if (i>0){
                    FGButton *but = [self.buttons objectForKey:self.model.field[i-1][j]];
                    but.isOnLeftFromVoid=YES;
                }
                if (i<3){
                    FGButton *but = [self.buttons objectForKey:self.model.field[i+1][j]];
                    but.isOnRightFromVoid=YES;
                }
                if (j>0){
                    FGButton *but = [self.buttons objectForKey:self.model.field[i][j-1]];
                    but.isUpperVoid=YES;
                }
                if (j<3){
                    FGButton *but = [self.buttons objectForKey:self.model.field[i][j+1]];
                    but.isLowerVoid=YES;
                }
            }
        }
    }
}

-(void)clearButtonsClickability{
    for(int i=0;i<self.model.field.count; i++){
        for(int j=0; j<self.model.field.count; j++){
            if(![self.model.field[i][j] isEqual:@0]){
                FGButton *but = [self.buttons objectForKey:self.model.field[i][j]];
                [but clearClickability];
            }
        }
    }
}

-(void)drawFieldFromModel{
    CGFloat fSize = self.frame.size.height;
    CGFloat emptSize = fSize/32;
    CGFloat bSize = (fSize - emptSize*5)/4;
    self.buttons = [[NSMutableDictionary alloc] initWithCapacity:14];
    for(int i=0;i<self.model.field.count; i++){
        for(int j=0; j<self.model.field.count; j++){
            if(![self.model.field[i][j] isEqual:@0]){
                FGButton *but = [FGButton initWithNumber:[self.model.field[i][j] integerValue] andField:self];
                [but setTitle:[NSString stringWithFormat:@"%@", self.model.field[i][j]] forState:UIControlStateNormal];
                [but setFrame: CGRectMake(emptSize+i*(emptSize+bSize), emptSize+j*(emptSize+bSize), bSize, bSize)];
                [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [self addSubview:but];
                [self.buttons setObject:but forKey:self.model.field[i][j]];
            }
        }
    }
    [self makeButtonsClickable];
}



- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.bounds.size.height/32];
    [self.fieldColor setFill];
    [path fill];
}

-(void)setNeedsDisplay{
    [super setNeedsDisplay];
    for (NSString *aKey in [self.buttons allKeys]){
        FGButton *but = [self.buttons objectForKey:aKey];
        [but setNeedsDisplay];
    }
}

@end
IB_DESIGNABLE
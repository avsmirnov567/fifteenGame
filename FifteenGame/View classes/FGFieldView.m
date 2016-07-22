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
#import "CoreGraphics/CoreGraphics.h"
#import "FGMainViewController.h"

IB_DESIGNABLE
@interface FGFieldView()

@property (nonatomic, weak)FGMainViewController *controller;
@property (nonatomic, strong) NSMutableDictionary *buttons;
@property (nonatomic) IBInspectable UIColor *fieldColor;

@end

@implementation FGFieldView

-(void)clearField{
    
    for (NSString *aKey in [self.buttons allKeys]){
        FGButton *but = [self.buttons objectForKey:aKey];
        [but removeFromSuperview];
    }
    [self.buttons removeAllObjects];
    [self.model clearModel];
}

-(void)initModelWithStartPositionAndController:(FGMainViewController *)controller{
    self.model = [[FGGameModel alloc] initWithValidPosition:[[FGGameManager sharedInstance] getValidPosition]];
    [self.model makeStartPosition];
    self.controller = controller;
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

CGMutablePathRef createRoundedCornerPath(CGRect rect, CGFloat cornerRadius) {
    
    // create a mutable path
    CGMutablePathRef path = CGPathCreateMutable();
    
    // get the 4 corners of the rect
    CGPoint topLeft = CGPointMake(rect.origin.x, rect.origin.y);
    CGPoint topRight = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
    CGPoint bottomRight = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    CGPoint bottomLeft = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
    
    // move to top left
    CGPathMoveToPoint(path, NULL, topLeft.x + cornerRadius, topLeft.y);
    
    // add top line
    CGPathAddLineToPoint(path, NULL, topRight.x - cornerRadius, topRight.y);
    
    // add top right curve
    CGPathAddQuadCurveToPoint(path, NULL, topRight.x, topRight.y, topRight.x, topRight.y + cornerRadius);
    
    // add right line
    CGPathAddLineToPoint(path, NULL, bottomRight.x, bottomRight.y - cornerRadius);
    
    // add bottom right curve
    CGPathAddQuadCurveToPoint(path, NULL, bottomRight.x, bottomRight.y, bottomRight.x - cornerRadius, bottomRight.y);
    
    // add bottom line
    CGPathAddLineToPoint(path, NULL, bottomLeft.x + cornerRadius, bottomLeft.y);
    
    // add bottom left curve
    CGPathAddQuadCurveToPoint(path, NULL, bottomLeft.x, bottomLeft.y, bottomLeft.x, bottomLeft.y - cornerRadius);
    
    // add left line
    CGPathAddLineToPoint(path, NULL, topLeft.x, topLeft.y + cornerRadius);
    
    // add top left curve
    CGPathAddQuadCurveToPoint(path, NULL, topLeft.x, topLeft.y, topLeft.x + cornerRadius, topLeft.y);
    
    // return the path
    return path;
}

- (void)drawRect:(CGRect)rect {
    // constants
    const CGFloat outlineStrokeWidth = 5.0f;
    const CGFloat outlineCornerRadius = self.bounds.size.height/32;
    
    const CGColorRef whiteColor = [self.fieldColor CGColor];
    const CGColorRef brownColor = [[UIColor brownColor] CGColor];
    
    // get the context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the background color to white
    CGContextSetFillColorWithColor(context, whiteColor);
    CGContextFillRect(context, rect);
    
    // inset the rect because half of the stroke applied to this path will be on the outside
    CGRect insetRect = CGRectInset(rect, outlineStrokeWidth/2.0f, outlineStrokeWidth/2.0f);
    
    // get our rounded rect as a path
    CGMutablePathRef path = createRoundedCornerPath(insetRect, outlineCornerRadius);
    
    // add the path to the context
    CGContextAddPath(context, path);
    
    // set the stroke params
    CGContextSetStrokeColorWithColor(context, brownColor);
    CGContextSetLineWidth(context, outlineStrokeWidth);
    
    // draw the path
    CGContextDrawPath(context, kCGPathStroke);
    
    // release the path
    CGPathRelease(path);
    
}

-(void)setNeedsDisplay{
    [super setNeedsDisplay];

    for (NSString *aKey in [self.buttons allKeys]){
        FGButton *but = [self.buttons objectForKey:aKey];
        [but setNeedsDisplay];
    }
}

-(void)checkForFinish{
    [self.controller checkForFinish];
}
@end
IB_DESIGNABLE
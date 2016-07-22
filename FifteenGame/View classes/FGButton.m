//
//  FGButton.m
//  FifteenGame
//
//  Created by Aleksandr Smirnov on 19/07/16.
//  Copyright © 2016 Aleksandr Smirnov. All rights reserved.
//

#import "FGButton.h"
#import "FGFieldView.h"
#import "CoreGraphics/CoreGraphics.h"


@implementation FGButton

+(instancetype)initWithNumber:(NSInteger)number andField:(FGFieldView *)field{
    FGButton *button = [FGButton new];
    button.number = number;
    button.field = field;
    button.isUpperVoid = NO;
    button.isLowerVoid = NO;
    button.isOnRightFromVoid = NO;
    button.isOnLeftFromVoid = NO;
    return button;
}

-(BOOL)isClickable{
    if(self.isUpperVoid||self.isLowerVoid||self.isOnLeftFromVoid||self.isOnRightFromVoid){
        return YES;
    }else{
        return NO;
    }
}

-(void)clearClickability{
    self.isUpperVoid=NO;
    self.isLowerVoid=NO;
    self.isOnLeftFromVoid=NO;
    self.isOnRightFromVoid=NO;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.height/32];
    [[UIColor yellowColor] setFill];
    [path fill];
}

//-(void)setNeedsDisplay{
//    [super setNeedsDisplay];
//    self.layer.contents = (id)[UIImage imageNamed:@"but.jpg"].CGImage;
//}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if([self isClickable]){
        if(self.isLowerVoid){
            [self moveUp];
            return;
        }
        if(self.isUpperVoid){
            [self moveDown];
            return;
        }
        if(self.isOnLeftFromVoid){
            [self moveRight];
            return;
        }
        if(self.isOnRightFromVoid){
            [self moveLeft];
            return;
        }
    }
}

-(void)moveUp{
    [self.field.model moveVoidDown];
    [self.field makeButtonsClickable];
    CGRect frame = self.frame;
    CGFloat fSize = self.field.frame.size.height;
    CGFloat emptSize = fSize/32;
    CGFloat bSize = (fSize - emptSize*5)/4;
    frame.origin.y-=emptSize+bSize;

    [UIView animateWithDuration:0.1 animations:^{
        self.frame = frame;
    }];
    [self.field setNeedsDisplay];
    [self.field checkForFinish];
}

-(void)moveDown{
    [self.field.model moveVoidUp];
    [self.field makeButtonsClickable];
    CGRect frame = self.frame;
    CGFloat fSize = self.field.frame.size.height;
    CGFloat emptSize = fSize/32;
    CGFloat bSize = (fSize - emptSize*5)/4;
    frame.origin.y+=emptSize+bSize;
    [UIView animateWithDuration:0.1 animations:^{
        self.frame = frame;
    }];
    [self.field setNeedsDisplay];
    [self.field checkForFinish];

}

-(void)moveLeft{
    [self.field.model moveVoidRight];
    [self.field makeButtonsClickable];
    CGRect frame = self.frame;
    CGFloat fSize = self.field.frame.size.height;
    CGFloat emptSize = fSize/32;
    CGFloat bSize = (fSize - emptSize*5)/4;
    frame.origin.x-=emptSize+bSize;
    [UIView animateWithDuration:0.1 animations:^{
        self.frame = frame;
    }];
    [self.field setNeedsDisplay];
    [self.field checkForFinish];

}

-(void)moveRight{
    [self.field.model moveVoidLeft];
    [self.field makeButtonsClickable];
    CGRect frame = self.frame;
    CGFloat fSize = self.field.frame.size.height;
    CGFloat emptSize = fSize/32;
    CGFloat bSize = (fSize - emptSize*5)/4;
    frame.origin.x+=emptSize+bSize;
    [UIView animateWithDuration:0.1 animations:^{
        self.frame = frame;
    }];
    [self.field setNeedsDisplay];
    [self.field checkForFinish];

}
@end

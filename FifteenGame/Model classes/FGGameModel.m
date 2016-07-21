//
//  FGGameModel.m
//  FifteenGame
//
//  Created by Aleksandr Smirnov on 18/07/16.
//  Copyright © 2016 Aleksandr Smirnov. All rights reserved.
//

#import "FGGameModel.h"
#import "FGGameManager.h"

@implementation FGGameModel

-(instancetype)initWithValidPosition:(NSMutableArray *)validPosition{
    self.field = [NSMutableArray new];
    self.field = validPosition;
    self.voidX = kVoidValidX;
    self.voidY = kVoidValidY;
    return self;
}

-(void)makeStartPosition{
    NSInteger direction;
    NSInteger times = kSide*20; //число перестановок
    
    for (int i=0; i<times; i++){
        direction = arc4random() % 4;
        
        switch (direction) {
            case 0:
                if(self.voidY>0){ //сдвиг "пустышки" вверх
                    [self moveVoidUp];
                }else{ //сдвиг всего столбца вверх
                    [self moveColumnUp];
                }
                break;
            case 1:
                if(self.voidY<kSide-1){ //сдвиг "пустышки" вниз
                    [self moveVoidDown];
                }else{ //сдвиг всего столбца вниз
                    [self moveColumnDown];
                }
                break;
            case 2:
                if(self.voidX>0){ //сдвиг "пустышки" влево
                    [self moveVoidLeft];
                }else{ //сдвиг всей строки влево
                    [self moveStringLeft];
                }
                break;
            case 3:
                if(self.voidY<kSide-1){ //сдвиг "пустышки" вправо
                    [self moveVoidRight];
                }else{ //сдвиг всей строки вправо
                    [self moveStringRight];
                }
                break;
        }
    }
}

-(void)moveVoidUp{
    if(self.voidY>0){
        self.field[self.voidX][self.voidY]=self.field[self.voidX][self.voidY-1];
        self.field[self.voidX][self.voidY-1]= @0;
        self.voidY--;
    }
}

-(void)moveVoidDown{
    if(self.voidY<kSide-1){
        self.field[self.voidX][self.voidY]=self.field[self.voidX][self.voidY+1];
        self.field[self.voidX][self.voidY+1]= @0;
        self.voidY++;
    }
}

-(void)moveVoidLeft{
    if(self.voidX>0){
        self.field[self.voidX][self.voidY]=self.field[self.voidX-1][self.voidY];
        self.field[self.voidX-1][self.voidY]= @0;
        self.voidX--;
    }
}

-(void)moveVoidRight{
    if(self.voidX<kSide-1){
        self.field[self.voidX][self.voidY]=self.field[self.voidX+1][self.voidY];
        self.field[self.voidX+1][self.voidY]= @0;
        self.voidX++;
    }
}

-(void)moveColumnUp{
    if(self.voidY == 0){
        for (int j=0;j<kSide-1;j++){
            self.field[self.voidX][j]=self.field[self.voidX][j+1];
        }
        self.field[self.voidX][kSide-1]= @0;
        self.voidY=kSide-1;
    }
}
-(void)moveColumnDown{
    if (self.voidY==kSide-1){
        for (int j=kSide-1;j>0;j--){
            self.field[self.voidX][j]=self.field[self.voidX][j-1];
        }
        self.field[self.voidX][0]= @0;
        self.voidY=0;
    }
}
-(void)moveStringRight{
    if (self.voidX==kSide-1){
        for (int j=kSide-1;j>0;j--){
            self.field[j][self.voidY]=self.field[j-1][self.voidY];
        }
        self.field[0][self.voidY]= @0;
        self.voidX=0;
    }
}
-(void)moveStringLeft{
    if(self.voidX == 0)
    {
        for (int j=0;j<kSide-1;j++){
            self.field[j][self.voidY]=self.field[j+1][self.voidY];
        }
        self.field[kSide-1][self.voidY]= @0;
        self.voidX=kSide-1;
    }

}


@end

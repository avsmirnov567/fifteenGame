//
//  FGFieldView.h
//  FifteenGame
//
//  Created by Aleksandr Smirnov on 19/07/16.
//  Copyright © 2016 Aleksandr Smirnov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGGameModel.h"
#import "FGMainViewController.h"

@interface FGFieldView : UIView

@property (nonatomic, strong) FGGameModel *model;

-(void)initModelWithStartPositionAndController:(FGMainViewController *)controller;
-(void)drawFieldFromModel;
-(void)makeButtonsClickable;
-(void)clearButtonsClickability;
-(void)checkForFinish;
-(void)clearField;

@end

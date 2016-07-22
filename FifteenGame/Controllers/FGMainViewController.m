//
//  FGMainViewController.m
//  FifteenGame
//
//  Created by Aleksandr Smirnov on 19/07/16.
//  Copyright © 2016 Aleksandr Smirnov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FGMainViewController.h"
#import "FGFieldView.h"
#import "FGGameManager.h"

@interface FGMainViewController()


@property (weak, nonatomic) IBOutlet FGFieldView *fieldView;

@end

@implementation FGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.fieldView initModelWithStartPositionAndController:self];
    [self.fieldView drawFieldFromModel];
    [self.resetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(NSString *)printModel{
    NSString *str1 = [NSString stringWithFormat:@"%@ ,%@ ,%@ ,%@", self.fieldView.model.field[0][0],self.fieldView.model.field[1][0],self.fieldView.model.field[2][0],self.fieldView.model.field[3][0]];
    NSString *str2 = [NSString stringWithFormat:@"%@ ,%@ ,%@ ,%@", self.fieldView.model.field[0][1],self.fieldView.model.field[1][1],self.fieldView.model.field[2][1],self.fieldView.model.field[3][1]];
    NSString *str3 = [NSString stringWithFormat:@"%@ ,%@,%@,%@", self.fieldView.model.field[0][2],self.fieldView.model.field[1][2],self.fieldView.model.field[2][2],self.fieldView.model.field[3][2]];
    NSString *str4 = [NSString stringWithFormat:@"%@,%@,%@,%@", self.fieldView.model.field[0][3],self.fieldView.model.field[1][3],self.fieldView.model.field[2][3],self.fieldView.model.field[3][3]];
    return [NSString stringWithFormat:@"%@\n%@\n%@\n%@",str1,str2,str3,str4];
}

-(NSUInteger) supportedInterfaceOrientations {
    // Return a bitmask of supported orientations. If you need more,
    // use bitwise or (see the commented return).
    return UIInterfaceOrientationMaskPortrait;
    // return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    // Return the orientation you'd prefer - this is what it launches to. The
    // user can still rotate. You don't have to implement this method, in which
    // case it launches in the current orientation
    return UIInterfaceOrientationPortrait;
}

-(void)checkForFinish{
    NSMutableArray *valid = [[FGGameManager sharedInstance ] getValidPosition];
    BOOL isValid = YES;
    for(int i=0;i<self.fieldView.model.field.count; i++){
        for(int j=0; j<self.fieldView.model.field.count; j++){
            if([self.fieldView.model.field[i][j] isEqual: valid[i][j]]){
                isValid = YES;
            }else{
                isValid = NO;
                break;
            }
        }
    }
    if (isValid){
        [self.fieldView clearButtonsClickability];
        [self.topLabel setText:@"YOU WIN!!!"];
        [self.resetButton setTitle:@"Start again" forState:UIControlStateNormal];
    }
}

- (IBAction)btnResetClicked:(id)sender {
    [self.fieldView clearField];
    [self.fieldView initModelWithStartPositionAndController:self];
    [self.fieldView drawFieldFromModel];
    [self.topLabel setText:@"Try to order..."];
    [self.resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    [self.fieldView setNeedsDisplay];
}

@end

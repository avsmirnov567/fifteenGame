//
//  ViewController.m
//  FifteenGame
//
//  Created by Aleksandr Smirnov on 18/07/16.
//  Copyright © 2016 Aleksandr Smirnov. All rights reserved.
//

#import "ViewController.h"
#import "FGGameModel.h"
#import "FGGameManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *fieldContainer;
@property (nonatomic, strong) FGGameModel *model;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.model = [[FGGameModel alloc] initWithValidPosition:[[FGGameManager sharedInstance] getValidPosition]];
    self.fieldContainer.text = self.printModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnUpdateClicked:(id)sender {
    [self.model moveVoidUp];
    self.fieldContainer.text = self.printModel;
}
- (IBAction)btnDownClicked:(id)sender {
    [self.model moveVoidDown];
    self.fieldContainer.text = self.printModel;
}
- (IBAction)btnCUpClicked:(id)sender {
    [self.model moveColumnUp];
    self.fieldContainer.text = self.printModel;
}
- (IBAction)btnCdownClicked:(id)sender {
    [self.model moveColumnDown];
    self.fieldContainer.text = self.printModel;
}
- (IBAction)btnRightClicked:(id)sender {
    [self.model moveVoidRight];
    self.fieldContainer.text = self.printModel;
}
- (IBAction)btnLeftClicked:(id)sender {
    [self.model moveVoidLeft];
    self.fieldContainer.text = self.printModel;
}
- (IBAction)btnSRightClicked:(id)sender {
    [self.model moveStringRight];
    self.fieldContainer.text = self.printModel;
}
- (IBAction)btnSLeftCkicked:(id)sender {
    [self.model moveStringLeft];
    self.fieldContainer.text = self.printModel;
}
- (IBAction)btnNewClicked:(id)sender {
    [self.model makeStartPosition];
    self.fieldContainer.text = self.printModel;
}


-(NSString *)printModel{
    NSString *str1 = [NSString stringWithFormat:@"%@ ,%@ ,%@ ,%@", self.model.field[0][0],self.model.field[1][0],self.model.field[2][0],self.model.field[3][0]];
    NSString *str2 = [NSString stringWithFormat:@"%@ ,%@ ,%@ ,%@", self.model.field[0][1],self.model.field[1][1],self.model.field[2][1],self.model.field[3][1]];
    NSString *str3 = [NSString stringWithFormat:@"%@ ,%@,%@,%@", self.model.field[0][2],self.model.field[1][2],self.model.field[2][2],self.model.field[3][2]];
    NSString *str4 = [NSString stringWithFormat:@"%@,%@,%@,%@", self.model.field[0][3],self.model.field[1][3],self.model.field[2][3],self.model.field[3][3]];
    return [NSString stringWithFormat:@"%@\n%@\n%@\n%@",str1,str2,str3,str4];
}

@end

//
//  FGMainViewController.m
//  FifteenGame
//
//  Created by Aleksandr Smirnov on 19/07/16.
//  Copyright © 2016 Aleksandr Smirnov. All rights reserved.
//

#import "FGMainViewController.h"
#import "FGFieldView.h"

@interface FGMainViewController()


@property (weak, nonatomic) IBOutlet FGFieldView *fieldView;
@property (weak, nonatomic) IBOutlet UILabel *lbl;

@end

@implementation FGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.fieldView initModelWithStartPosition];
    [self.fieldView drawFieldFromModel];
    self.lbl.text = [self printModel];
}

-(NSString *)printModel{
    NSString *str1 = [NSString stringWithFormat:@"%@ ,%@ ,%@ ,%@", self.fieldView.model.field[0][0],self.fieldView.model.field[1][0],self.fieldView.model.field[2][0],self.fieldView.model.field[3][0]];
    NSString *str2 = [NSString stringWithFormat:@"%@ ,%@ ,%@ ,%@", self.fieldView.model.field[0][1],self.fieldView.model.field[1][1],self.fieldView.model.field[2][1],self.fieldView.model.field[3][1]];
    NSString *str3 = [NSString stringWithFormat:@"%@ ,%@,%@,%@", self.fieldView.model.field[0][2],self.fieldView.model.field[1][2],self.fieldView.model.field[2][2],self.fieldView.model.field[3][2]];
    NSString *str4 = [NSString stringWithFormat:@"%@,%@,%@,%@", self.fieldView.model.field[0][3],self.fieldView.model.field[1][3],self.fieldView.model.field[2][3],self.fieldView.model.field[3][3]];
    return [NSString stringWithFormat:@"%@\n%@\n%@\n%@",str1,str2,str3,str4];
}

@end

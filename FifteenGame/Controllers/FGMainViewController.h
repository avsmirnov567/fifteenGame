//
//  FGMainViewController.h
//  FifteenGame
//
//  Created by Aleksandr Smirnov on 19/07/16.
//  Copyright © 2016 Aleksandr Smirnov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGMainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
-(NSString *)printModel;
-(void)checkForFinish;
@end

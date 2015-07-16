//
//  ViewController.m
//  SUActionSheet
//
//  Created by SuPan on 15/7/16.
//  Copyright © 2015年 SuPan. All rights reserved.
//

#import "ViewController.h"
#import "SUActionSheet.h"

@interface ViewController ()

- (IBAction)show:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(UIButton *)sender {
    
    SUActionSheet *sheet = [SUActionSheet sharedManger];
    sheet.automaticSwitchWindow = YES;
    [sheet setContentView:^UIView *{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 320, 200)];
        view.backgroundColor = [UIColor yellowColor];
        return view;
    }];
    [sheet showSUSheetAnimated:YES];
}
@end

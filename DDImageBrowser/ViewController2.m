//
//  ViewController2.m
//  DDImageBrowser
//
//  Created by Aimeow on 8/7/15.
//  Copyright (c) 2015 Aimeow. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *x;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *y;

@end

@implementation ViewController2
- (IBAction)click:(id)sender {
    [self.x setConstant:self.x.constant+1];
//    [self.y setConstant:100];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ViewController.m
//  __ProjectName__
//
//  Created by yyy on 2018/5/24.
//  Copyright © 2018年 yyy. All rights reserved.
//

#import "ViewController.h"
#import <YYYProgressHUD.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [YYYProgressHUD showLoadingHUD];
    [YYYProgressHUD showTextHUDAddedTo:self.view text:@"哈哈哈"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  __ProjectName__
//
//  Created by yyy on 2018/5/24.
//  Copyright © 2018年 yyy. All rights reserved.
//

#import "ViewController.h"
#import <YYYProgressHUD.h>
#import "YYYRingShapedView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    YYYRingShapedView *view = [YYYProgressHUD showRingShapedHUD].ringShapedView;
//    view.progress = 0.5;
    [self yyyupdate];
//    [YYYProgressHUD showTextHUDAddedTo:self.view text:@"哈哈哈"];

}

- (void)yyyupdate {
    [YYYProgressHUD HUDForView:nil].ringShapedView.progress += 0.1;
    if ([YYYProgressHUD HUDForView:nil].ringShapedView.progress > 1) {
        [YYYProgressHUD HUDForView:nil].ringShapedView.progress = 0;
    }
    [self performSelector:@selector(yyyupdate) withObject:nil afterDelay:1];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

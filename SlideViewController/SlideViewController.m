
//
//  SlideViewController.m
//  SlideViewController
//
//  Created by 周智勇 on 17/2/27.
//  Copyright © 2017年 周智勇. All rights reserved.
//

#import "SlideViewController.h"
#import "SubViewController.h"


@interface SlideViewController ()
@property (nonatomic, strong) NSArray  * typeAry;
@end

@implementation SlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"滑动视图控制器";
    
    self.titlesArr = [NSArray arrayWithObjects:@"热门",@"养生",@"运动",@"心理",@"新闻", nil];
    _typeAry = @[@"1",@"2",@"3",@"4",@"5"];
    [self updateSuperTitleAry];
}

- (void)addChildViewController{
    for (int i = 0; i < self.titlesArr.count; i++) {
        SubViewController * vc = [[SubViewController alloc] init];
        vc.title  =  self.titlesArr[i];
        vc.metype = _typeAry[i];
        [self addChildViewController:vc];
    }
}



@end

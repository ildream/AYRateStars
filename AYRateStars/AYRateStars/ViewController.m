//
//  ViewController.m
//  AYRateStars
//
//  Created by Anya on 2018/3/20.
//  Copyright © 2018年 Anya. All rights reserved.
//

#import "ViewController.h"
#import "AYRateStarsView.h"

@interface ViewController ()

@property (nonatomic, strong) AYRateStarsView *rateStarsView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    _rateStarsView = [[AYRateStarsView alloc] initWithFrame:CGRectMake(10, 200, [UIScreen mainScreen].bounds.size.width-20, 60)];
    _rateStarsView.starWidth = 36;
    _rateStarsView.starHeight = 36;
    [self.view addSubview:_rateStarsView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

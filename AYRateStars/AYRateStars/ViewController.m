//
//  ViewController.m
//  AYRateStars
//
//  Created by Anya on 2018/3/20.
//  Copyright © 2018年 Anya. All rights reserved.
//

#import "ViewController.h"
#import "AYRateStarsView.h"

@interface ViewController ()<RateStarDelegate>

@property (nonatomic, strong) AYRateStarsView *rateStarsView;
@property (nonatomic, strong) NSArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _arr = @[@"差没了",@"差评",@"一般",@"很好",@"十分满意"];
 
    [self initDataWithRateStarView];
  
    [self.view addSubview:_rateStarsView];
}

- (void)initDataWithRateStarView
{
    _rateStarsView = [[AYRateStarsView alloc] initWithFrame:CGRectMake(10, 200, [UIScreen mainScreen].bounds.size.width-20, 60) isSupportHalfStar:YES];
    _rateStarsView.delegate = self;
//    _rateStarsView.starWidth = 30;
//    _rateStarsView.starHeight = 30;
//    _rateStarsView.starImgGap = 10;
//    _rateStarsView.starOriginX = 30;
//    _rateStarsView.isSupportKeepFirstStar = YES;
//    _rateStarsView.isSupportSwipeStar = NO;
//    _rateStarsView.isSuppportTapStar = NO;
    [_rateStarsView initData];
}

#pragma mark - RateStarDelegate
- (void)rateStarEventHandler:(NSInteger)starNumber withImageType:(RateStarImageType)imageType
{
    NSLog(@"starNumber = %ld,imageType = %lu",starNumber,imageType);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

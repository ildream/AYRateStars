//
//  AYRateStars.m
//  AYRateStars
//
//  Created by Anya on 2018/3/20.
//  Copyright © 2018年 Anya. All rights reserved.
//

#import "AYRateStarsView.h"

#define kStarImgHeight 36
#define kStarImgWidth  36
#define kStarImgsGap 14

@interface AYRateStarsView()

@property (nonatomic, strong) NSMutableArray *starImgs;

@end

@implementation AYRateStarsView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithRed:24/255.0 green:242/255.0 blue:142/255.0 alpha:1];
        [self initDataWithImageView:frame];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder])
    {
        
    }
    return self;
}

//MARK:初始化UIIamgeView相关数据
- (void)initDataWithImageView:(CGRect)frame
{
    if (!_starImgs) {
        _starImgs = @[].mutableCopy;
    }
    __block CGFloat imgGapWithScreenEdge = (frame.size.width - 5*kStarImgWidth - 4*kStarImgsGap)/2.0;
    __block CGFloat originY = (frame.size.height - kStarImgHeight)/2.0;
    
    for (int idx = 0; idx<5; idx++)
    {
        UIImageView *obj = [[UIImageView alloc] initWithFrame:CGRectMake(imgGapWithScreenEdge+(idx*(kStarImgWidth+kStarImgsGap)), originY, kStarImgWidth, kStarImgHeight)];
        obj.contentMode = UIViewContentModeScaleAspectFit;
        obj.image = [UIImage imageNamed:@"deliver_comment_graystar"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapStarImgsEvent:)];
        obj.userInteractionEnabled = YES;
        [obj addGestureRecognizer:tap];
        [self addSubview:obj];
        [_starImgs addObject:obj];
    }
}

//MARK: 处理点击StarImg事件
- (void)tapStarImgsEvent:(UITapGestureRecognizer *)sender
{
    
}

@end

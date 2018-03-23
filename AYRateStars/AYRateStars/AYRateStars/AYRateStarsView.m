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
@property (nonatomic, assign) BOOL firstStarChangeGray;
@property (nonatomic, assign) RateStarImageType imageType;
@property (nonatomic, assign) NSInteger idxOfStarImgs;//当前星星的索引

@end

@implementation AYRateStarsView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithRed:24/255.0 green:242/255.0 blue:142/255.0 alpha:1];
        [self initData];
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

- (void)initData
{
    self.isSupportHalfStar = YES;
    self.starWidth = kStarImgWidth;
    self.starHeight = kStarImgHeight;
}

-(void)setStarWidth:(CGFloat)starWidth
{
    _starWidth = starWidth;
    if (_starWidth != kStarImgWidth) {
        [self setStarImgsSize];
    }
}

- (void)setStarHeight:(CGFloat)starHeight
{
    _starHeight = starHeight;
    if (_starHeight != kStarImgHeight) {
        [self setStarImgsSize];
    }
}

- (void)setStarImgsSize
{
    [_starImgs enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect f = obj.frame;
        f.size.height = _starHeight;
        f.size.width = _starWidth;
        f.origin.x = [self getImgGapWithScreenEdge]+(idx*(_starWidth+kStarImgsGap));
        f.origin.y = [self getOriginY];
        obj.frame = f;
    }];
}

- (CGFloat)getImgGapWithScreenEdge
{
    return (self.frame.size.width - 5*_starWidth - 4*kStarImgsGap)/2.0;
}

- (CGFloat)getOriginY
{
    return (self.frame.size.height - _starHeight)/2.0;
}

//MARK:初始化UIIamgeView相关数据
- (void)initDataWithImageView:(CGRect)frame
{
    if (!_starImgs) {
        _starImgs = @[].mutableCopy;
    }
    
    for (int idx = 0; idx<5; idx++)
    {
        UIImageView *obj = [[UIImageView alloc] initWithFrame:CGRectMake([self getImgGapWithScreenEdge]+(idx*(_starWidth+kStarImgsGap)), [self getOriginY], _starWidth, _starHeight)];
        obj.contentMode = UIViewContentModeScaleAspectFit;
        obj.image = [UIImage imageNamed:@"rate_graystar"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapStarImgsHandler:)];
        obj.userInteractionEnabled = YES;
        obj.tag = idx;
        [obj addGestureRecognizer:tap];
        [self addSubview:obj];
        [_starImgs addObject:obj];
    }
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panStarImgsHandler:)];
    [self addGestureRecognizer:panGesture];
}

//MARK: 处理点击StarImg事件
- (void)tapStarImgsHandler:(UITapGestureRecognizer *)sender
{
    CGPoint p = [sender locationInView:sender.view];
    NSInteger idxOfStarImgs = sender.view.tag;
    UIImageView *img = _starImgs[idxOfStarImgs];
    CGFloat minX = CGRectGetMinX(img.frame);
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        p.x += minX;
        [self changeStarImgStatus:[self getIndexOfTouchStarImg:p isTapGesture:YES] isTapGesture:YES];
    }
}

- (void)panStarImgsHandler:(UIPanGestureRecognizer *)sender
{
    CGPoint p = [sender locationInView:sender.view];
    NSInteger idx = [self getIndexOfTouchStarImg:p  isTapGesture:NO];
    [self changeStarImgStatus:idx isTapGesture:NO];
}

- (NSInteger)getIndexOfTouchStarImg:(CGPoint)currentPoint isTapGesture:(BOOL)isTapGesture
{
    __block CGFloat minX = 0;
    __block CGFloat midX = 0;
    __block CGFloat maxX = 0;
    __block CGFloat currentPointX = currentPoint.x;
    
    [self.starImgs enumerateObjectsUsingBlock:^(UIImageView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        minX = CGRectGetMinX(obj.frame);
        midX = CGRectGetMidX(obj.frame);
        maxX = CGRectGetMaxX(obj.frame);
        
        if (minX > currentPointX && idx == 0) {
            self.firstStarChangeGray = YES;
            self.imageType = RateStarImageType_Gray;
            *stop = YES;
        }else{
            self.firstStarChangeGray = NO;
        }
        
        if (minX < currentPointX && midX >= currentPointX)
        {
            if (isTapGesture){
                //  currentPointX 触摸在0~1/4星星的区域时，使这颗星完全变灰。
                if (minX < currentPointX && currentPointX < (midX - _starWidth/4)) {
                    if (idx == 0) {
                        self.firstStarChangeGray = YES;
                        self.imageType = RateStarImageType_Gray;
                    }
                    else{
                        self.idxOfStarImgs = idx - 1;
                        self.imageType = RateStarImageType_Full;
                    }
                    *stop = YES;
                }
                else{ //1/4 ~ 1/2 之间
                    self.idxOfStarImgs = idx;
                    self.imageType = RateStarImageType_Half;
                    *stop = YES;
                }
            }
            else{
                self.idxOfStarImgs = idx;
                self.imageType = RateStarImageType_Half;
                *stop = YES;
            }
        }
        else if (maxX > currentPointX && currentPointX > midX)
        {
            self.idxOfStarImgs = idx;
            self.imageType = RateStarImageType_Full;
            *stop = YES;
        }
    }];
    
    return self.idxOfStarImgs;
}

- (void)changeStarImgStatus:(NSInteger)index isTapGesture:(BOOL)isTapGesture
{
    if (index != -1) {// -1 表示所有星星都为灰色
        for (NSInteger i = 0; i <_starImgs.count; i++)
        {
            UIImageView *img = _starImgs[i];
            if (i<index){
                img.image = [UIImage imageNamed:@"rate_fullstar"];
            }
            else if (i==index){
                NSString *imageName = nil;
                if (self.imageType == RateStarImageType_Full) {
                    imageName = @"rate_fullstar";
                }
                else if (self.imageType == RateStarImageType_Half){
                    imageName = @"rate_halfstar";
                }
                else{
                    imageName = @"rate_graystar";
                }
                img.image = [UIImage imageNamed:imageName];
            }
            else{
                 img.image = [UIImage imageNamed:@"rate_graystar"];
            }
        }
    }
}

@end

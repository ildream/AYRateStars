//
//  AYRateStars.h
//  AYRateStars
//
//  Created by Anya on 2018/3/20.
//  Copyright © 2018年 Anya. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    RateStarImageType_Gray,
    RateStarImageType_Half,
    RateStarImageType_Full,
    RateStarImageType_None
} RateStarImageType;

@interface AYRateStarsView : UIView

//是否支持半星评级
@property (nonatomic, assign) BOOL isSupportHalfStar;

//是否支持第一颗星（或半颗星）选中后，无法消去选中状态
@property (nonatomic, assign) BOOL isSupportKeepFirstStar;

//是否支持滑动选中星星   default YES
@property (nonatomic, assign) BOOL isSupportSwipeStar;

//是否支持点击选中星星   default YES
@property (nonatomic, assign) BOOL isSuppportTapStar;

//星星size的 width
@property (nonatomic, assign) CGFloat starWidth;

//星星size的 height
@property (nonatomic, assign) CGFloat starHeight;

@end

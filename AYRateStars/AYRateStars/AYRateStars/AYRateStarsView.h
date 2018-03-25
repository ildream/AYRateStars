//
//  AYRateStars.h
//  AYRateStars
//
//  Created by Anya on 2018/3/20.
//  Copyright © 2018年 Anya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    RateStarImageType_Gray,
    RateStarImageType_Half,
    RateStarImageType_Full,
    RateStarImageType_None
} RateStarImageType;

@protocol RateStarDelegate<NSObject>

- (void)rateStarEventHandler:(NSInteger)starNumber withImageType:(RateStarImageType)imageType;

@end


@interface AYRateStarsView : UIView

/**
 初始化AYRateStarsView的方法

 @param frame AYRateStarsView 的frame
 @param isSupportHalfStar YES 表示支持半星，NO表示不支持半星
 @return self
 */
- (id)initWithFrame:(CGRect)frame isSupportHalfStar:(BOOL)isSupportHalfStar;


/**
 初始化一些必要的数据
 */
- (void)initData;

//是否支持第一颗星（或半颗星）选中后，无法消去选中状态
@property (nonatomic, assign) BOOL isSupportKeepFirstStar;

//是否支持滑动选中星星   default  YES
@property (nonatomic, assign) BOOL isSupportSwipeStar;

//是否支持点击选中星星   default  YES
@property (nonatomic, assign) BOOL isSuppportTapStar;

//星星size的 width
@property (nonatomic, assign) CGFloat starWidth;

//星星size的 height
@property (nonatomic, assign) CGFloat starHeight;

@property (nonatomic, assign) CGFloat starImgGap;

//星星的x 坐标，默认的starOriginx = (self.frame.size.width - 5*_starWidth - 4*kStarImgsGap)/2.0
@property (nonatomic, assign) CGFloat starOriginX;

/* 灰色星星、半星、亮星 自定义图片名称 */
@property (nonatomic, strong) NSString * halfStarImgName;

@property (nonatomic, strong) NSString * fullStarImgName;

@property (nonatomic, strong) NSString * grayStarImgName;

@property (nonatomic, weak) id <RateStarDelegate>delegate;

@end

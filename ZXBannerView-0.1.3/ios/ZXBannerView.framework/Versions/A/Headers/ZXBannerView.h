//
//  ZXBannerView.h
//  ZXBannerView
//
//  Created by Xie zexin on 03/15/2018.
//  Copyright (c) 2018 Xie zexin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXBannerData.h"


@interface ZXBannerView : UIView


- (void)setImagesWithBannerDatas:(nonnull NSArray*)datas
                  withTouchBlock:(void(^_Nullable)(id _Nullable data))touchBlock;

- (void)setImagesWithBannerDatas:(nonnull NSArray*)datas
                withRollInterval:(CGFloat)rollInterval      //翻页间隔
             withAnimateInterval:(CGFloat)animateInterval   //翻页动画时长
                  withTouchBlock:(void(^_Nullable)(id _Nullable data))touchBlock;

- (void)setImagesWithBannerDatas:(nonnull NSArray*)datas
                withRollInterval:(CGFloat)rollInterval
             withAnimateInterval:(CGFloat)animateInterval
      withPageIndicatorTintColor:(nonnull UIColor*)pageIndicatorTintColor   //pageController颜色
withCurrentPageIndicatorTintColor:(nonnull UIColor*)currentPageIndicatorTintColor   //PageController选中的颜色
                  withTouchBlock:(void(^_Nullable)(id _Nullable data))touchBlock;


- (void)reload;

@end

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

@property (nonatomic,assign) CGFloat rollInterval;
@property (nonatomic,assign) CGFloat animateInterval;


- (void)setImagesWithBannerDatas:(nonnull NSArray*)datas withTouchBlock:(void(^_Nullable)(id _Nullable data))touchBlock;

- (void)reload;

@end

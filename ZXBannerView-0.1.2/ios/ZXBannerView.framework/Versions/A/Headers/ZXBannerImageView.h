//
//  ZXBannerImageView.h
//  ZXBannerView
//
//  Created by Xie zexin on 03/15/2018.
//  Copyright (c) 2018 Xie zexin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXBannerData.h"

typedef void(^TouchImageBloc)(void);

@interface ZXBannerImageView : UIImageView

@property (nonatomic,copy) TouchImageBloc touchBlock;

@end

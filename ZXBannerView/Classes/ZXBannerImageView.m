//
//  ZXBannerImageView.m
//  ZXBannerView
//
//  Created by Xie zexin on 03/15/2018.
//  Copyright (c) 2018 Xie zexin. All rights reserved.
//

#import "ZXBannerImageView.h"

@implementation ZXBannerImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame] ){
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickImageView:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}


- (void)didClickImageView:(id)sender{
    if ( _touchBlock ){
        _touchBlock();
    }
}

@end

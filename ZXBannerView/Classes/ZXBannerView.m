//
//  ZXBannerView.m
//  ZXBannerView
//
//  Created by Xie zexin on 03/15/2018.
//  Copyright (c) 2018 Xie zexin. All rights reserved.
//

#import "ZXBannerView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>
#import "ZXBannerImageView.h"

@interface ZXBannerView()<UIScrollViewDelegate>

@property (weak, nonatomic) UIView *backgroundView;
@property (weak, nonatomic) UIPageControl *pageControl;
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) NSTimer* timer;
@property (nonatomic,strong) NSArray* imageViews;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong) NSArray* datas;
@property (nonatomic,strong) void(^touchBlock)(ZXBannerData* data);

@end

@implementation ZXBannerView

- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame] ){
        [self createViews];
    }
    return self;
}

- (instancetype)init{
    if ( self = [super init] ){
        [self createViews];
    }
    return self;
}

- (void)initScrollView{
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
}

- (void)createViews{
    UIView *backgroundView = [[UIView alloc] init];
    UIPageControl* pageControl = [[UIPageControl alloc] init];
    UIScrollView* scrollView = [[UIScrollView alloc] init];
    
    [self addSubview:(_backgroundView=backgroundView)];
    [backgroundView addSubview:(_scrollView=scrollView)];
    [backgroundView addSubview:(_pageControl=pageControl)];
    
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(backgroundView);
    }];
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backgroundView.mas_bottom);
        make.centerX.equalTo(backgroundView);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRotate:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)changeRotate:(NSNotification*)noti{
    [self reload];
}


- (void)setImagesWithBannerDatas:(nonnull NSArray*)datas withTouchBlock:(void(^_Nullable)(id _Nullable data))touchBlock;{
    _datas = datas;
    _touchBlock = touchBlock;
    [self layoutIfNeeded];
    //在数组的首部插入尾部的数据，在尾部插入首部的数据，实现首尾相接
    NSMutableArray* temp = [[NSMutableArray alloc] initWithArray:datas];
    id firstObject = temp.firstObject;
    id lastObject = temp.lastObject;
    [temp addObject:firstObject];
    [temp insertObject:lastObject atIndex:0];
    
    NSMutableArray* imageViews = [NSMutableArray array];

    //获取网络图片，并设置按钮回调block
    for ( NSInteger count = 0 ; count < temp.count ; count++ ){
        ZXBannerData* data = temp[count];
        ZXBannerImageView* imageView = [[ZXBannerImageView alloc] initWithFrame:CGRectMake(count*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        
        if ( touchBlock ){
            //在ZXBannerImageView中回调touchBlock
            imageView.touchBlock = ^{
                touchBlock(data);
            };
        }
        [imageView sd_setImageWithURL:data.url];
        [_scrollView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleToFill;
        _scrollView.contentSize = CGSizeMake((count + 1) * self.frame.size.width, 0);
        
        [imageViews addObject:imageView];
    }

    _imageViews = imageViews;
    [self initPageController:datas.count];
    [self initScrollView];
    [self createTimer];
    
}


- (void)reload{
    for ( id view in _scrollView.subviews ){
        [view removeFromSuperview];
    }
    [self setImagesWithBannerDatas:_datas withTouchBlock:_touchBlock];

}

//初始化pagecontroller的个数
- (void)initPageController:(NSInteger)numberOfPages{
    _pageControl.numberOfPages = numberOfPages;
    _pageControl.currentPage = numberOfPages;
    _currentPage = 0;
}

- (void)createTimer{
    if ( !_timer ){
        NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:_rollInterval?_rollInterval:3 target:self selector:@selector(rolling) userInfo:nil repeats:YES ];
        [[NSRunLoop currentRunLoop]addTimer:(_timer = timer) forMode:NSRunLoopCommonModes];
    }
}

- (void)rolling{
    //获取当前的点
    CGPoint point = _scrollView.contentOffset;
    
    //求得将要变换的点
    CGPoint endPoint = CGPointMake(point.x + self.frame.size.width, 0);
    
    //判断
    if ( endPoint.x == (self.imageViews.count-1) * self.frame.size.width ){
        [UIView animateWithDuration:_animateInterval?_animateInterval:0.5 animations:^{
            self.scrollView.contentOffset = CGPointMake(endPoint.x, 0);
        } completion:^(BOOL finished) {
            //动画完成的block
            self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
            CGPoint realEnd = self.scrollView.contentOffset;
            //取一遍页码数
            self.currentPage = realEnd.x / self.frame.size.width;
            self.pageControl.currentPage = self.currentPage - 1;
        }];
    }else{
        [UIView animateWithDuration:_animateInterval?_animateInterval:0.5 animations:^{
            self.scrollView.contentOffset = endPoint;
        } completion:^(BOOL finished) {
            CGPoint realEnd = self.scrollView.contentOffset;
            //取一遍页码数
            self.currentPage = realEnd.x / self.frame.size.width;
            self.pageControl.currentPage = self.currentPage - 1;
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ( _timer ){
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_rollInterval?_rollInterval:2]];
    }
    //图片的个数  1 2 3 4 5 6 7 8
    //真实的页码  0 1 2 3 4 5 6 7
    //显示的页码    0 1 2 3 4 5
    CGPoint point = _scrollView.contentOffset;
    if ( point.x == (self.imageViews.count-1)*self.frame.size.width ){
        scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
    if ( point.x == 0 ){
        scrollView.contentOffset = CGPointMake((self.imageViews.count-2)*self.frame.size.width, 0);
    }
    //取一遍页码数
    CGPoint endPoint = scrollView.contentOffset;
    _currentPage = endPoint.x / self.frame.size.width;
    _pageControl.currentPage = _currentPage - 1;
    
}

//手指开始触摸停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ( _timer ){
        [_timer setFireDate:[NSDate distantFuture]];
    }
}


@end

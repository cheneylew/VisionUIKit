//
//  XMAdScrollView.m
//  XMAdScrollView
//
//  Created by 宋乃银 on 16/11/1.
//  Copyright © 2016年 camhow. All rights reserved.
//

#import "XMAdScrollView.h"
#import "UIImageView+WebCache.h"

@interface XMAdScrollViewItem : UIView
@property(nonatomic,strong)UIImageView * imgView;
@property(nonatomic,strong)UITextField * titleTF;
@end


@implementation XMAdScrollViewItem

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        [self initImgView];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super initWithCoder:aDecoder])
    {
        [self initImgView];
    }
    return self;
}
-(instancetype)init
{
    if (self=[super init])
    {
        [self initImgView];
    }
    return self;
}
-(void)initImgView
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    if (!_imgView)
    {
        _imgView=[[UIImageView alloc] initWithFrame:self.bounds];
        _imgView.userInteractionEnabled=NO;
        _imgView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.layer.masksToBounds = YES;
        _imgView.image=[UIImage imageNamed:@"banner.jpg"];
        [self addSubview:_imgView];
        
        _titleTF = [[UITextField alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-24, self.bounds.size.width, 24)];
        _titleTF.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        _titleTF.userInteractionEnabled = NO;
        _titleTF.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
        _titleTF.hidden = YES;
        _titleTF.textColor = [UIColor whiteColor];
        _titleTF.font = [UIFont systemFontOfSize:12];
        _titleTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _titleTF.leftViewMode = UITextFieldViewModeAlways;
        _titleTF.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _titleTF.rightViewMode = UITextFieldViewModeAlways;
        [self addSubview:_titleTF];
    }
}

@end


@interface XMAdScrollView ()<UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
    
    XMAdScrollViewItem * _currentItem;
    XMAdScrollViewItem * _leftItem;
    XMAdScrollViewItem * _rightItem;
    
    UIPageControl * _pageControl;
    NSTimer * _timer;
    
    CGRect _lastFrame;
    
    
}
@property(nonatomic,assign)NSInteger currentIndex;
@end

@implementation XMAdScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        self.timeInterval = 5.0;
        [self initScrollView];
    }
    return self;
    
}
-(void)setPageControlAligment:(XMPageControlAlignment)pageControlAligment
{
    _pageControlAligment = pageControlAligment;
    CGSize size = [_pageControl sizeForNumberOfPages:_pageControl.numberOfPages];
    
    switch (_pageControlAligment)
    {
        case XMPageControlAlignmentLeft:
        {
            _pageControl.frame = CGRectMake(0, self.bounds.size.height-24, size.width+20, 24);
            _pageControl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin;
        }
            break;
        case XMPageControlAlignmentCenter:
        {
            _pageControl.frame = CGRectMake((self.bounds.size.width-size.width)*0.5, self.bounds.size.height-24, size.width, 24);
            _pageControl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
        }
            break;
        default:
        {
            _pageControl.frame = CGRectMake(self.bounds.size.width-size.width-20, self.bounds.size.height-24, size.width+20, 24);
            _pageControl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
        }
            break;
    }
}
-(void)setShowTitle:(BOOL)showTitle
{
    _showTitle = showTitle;
    _leftItem.titleTF.hidden = !_showTitle;
    _currentItem.titleTF.hidden = !_showTitle;
    _rightItem.titleTF.hidden = !_showTitle;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (!CGRectEqualToRect(_lastFrame, _scrollView.frame))
    {
        [self endTimer];
        _lastFrame = _scrollView.frame;
        _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*3, 0);
        _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
        
        _currentItem.frame = CGRectMake(_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
        _leftItem.frame = CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
        _rightItem.frame = CGRectMake(_scrollView.bounds.size.width*2.0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
        [self beginTimer];
    }
}
-(void)initScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_scrollView];
    
    
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*3, 0);
    _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
    
    _currentItem = [[XMAdScrollViewItem alloc] initWithFrame:CGRectMake(_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
    [_scrollView addSubview:_currentItem];
    [_currentItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)]];
    
    _leftItem = [[XMAdScrollViewItem alloc] initWithFrame:CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
    [_scrollView addSubview:_leftItem];
    
    _rightItem = [[XMAdScrollViewItem alloc] initWithFrame:CGRectMake(_scrollView.bounds.size.width*2.0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
    [_scrollView addSubview:_rightItem];
    
    _pageControl =  [[UIPageControl alloc] init];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.hidesForSinglePage = YES;
    [self addSubview:_pageControl];
    self.pageControlAligment = XMPageControlAlignmentRight;
    
}
-(void)tapImage
{
    if ([self.delegate respondsToSelector:@selector(adScrollView:didSelectedAtIndex:)])
    {
        [self.delegate adScrollView:self didSelectedAtIndex:self.currentIndex];
    }
}
-(void)setItemDataArray:(NSArray<id<XMAdScrollViewItemModelDelegate>> *)itemDataArray
{
    if (_itemDataArray != itemDataArray)
    {
        _itemDataArray = itemDataArray;
        self.currentIndex = 0;
         _pageControl.numberOfPages = _itemDataArray.count;
        self.pageControlAligment = self.pageControlAligment;
        [self endTimer];
        if (_itemDataArray.count>1)
        {
            [self beginTimer];
            _scrollView.scrollEnabled = YES;
        }
        else
        {
            _scrollView.scrollEnabled = NO;
        }
    }
}
-(void)setTimeInterval:(CGFloat)timeInterval
{
    if (_timeInterval!=timeInterval)
    {
        _timeInterval = timeInterval;
        
        if (_timer && _timer.isValid)
        {
            [self beginTimer];
        }
    }
}

-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    _pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}
-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    _pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

-(void)beginTimer
{
    [self endTimer];
    if (_itemDataArray.count>1)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval
                                                  target:self
                                                selector:@selector(automaticScroll)
                                                userInfo:nil
                                                 repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}
-(void)endTimer
{
    [_timer invalidate];
    _timer = nil;
}
- (void)automaticScroll
{
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width*2, 0) animated:YES];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_itemDataArray.count>0)
    {
        CGFloat criticalValue = .2f;
        
        if (scrollView.contentOffset.x > 2 * scrollView.bounds.size.width - criticalValue)
        {
            self.currentIndex = (self.currentIndex + 1) % self.itemDataArray.count;
        }
        else if (scrollView.contentOffset.x < criticalValue)
        {
            self.currentIndex = (self.currentIndex + self.itemDataArray.count - 1) % self.itemDataArray.count;
        }
    }
}
-(void)setCurrentIndex:(NSInteger)currentIndex
{
    if (currentIndex>=0)
    {
        _currentIndex = currentIndex;
        
        NSInteger leftIndex = (_currentIndex + self.itemDataArray.count - 1) % self.itemDataArray.count;
        NSInteger rightIndex= (_currentIndex + 1) % self.itemDataArray.count;
        
        
        _pageControl.currentPage = _currentIndex;
        
        [_currentItem.imgView sd_setImageWithURL:[NSURL URLWithString:[_itemDataArray[_currentIndex] itemImgURL]] placeholderImage:nil];
        
        [_leftItem.imgView sd_setImageWithURL:[NSURL URLWithString:[_itemDataArray[leftIndex] itemImgURL]] placeholderImage:nil];
        
        [_rightItem.imgView sd_setImageWithURL:[NSURL URLWithString:[_itemDataArray[rightIndex] itemImgURL]] placeholderImage:nil];
        
        if ([_itemDataArray[rightIndex] respondsToSelector:@selector(itemTitle)])
        {
            _rightItem.titleTF.text = [_itemDataArray[rightIndex] itemTitle];
            _leftItem.titleTF.text = [_itemDataArray[leftIndex] itemTitle];
            _currentItem.titleTF.text = [_itemDataArray[_currentIndex] itemTitle];
        }
        _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self beginTimer];
}

@end





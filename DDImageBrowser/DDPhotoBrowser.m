//
//  DDImageBrowser.m
//  DDImageBrowser
//
//  Created by Aimeow on 8/4/15.
//  Copyright (c) 2015 Aimeow. All rights reserved.
//

#import "DDPhotoBrowser.h"

//@interface DDPhotoBrowser () <UIScrollViewDelegate , UIActionSheetDelegate , DDPhotoViewDelegate>
@interface DDPhotoBrowser () <UIScrollViewDelegate , UIActionSheetDelegate>

@property (nonatomic , strong) UIWindow *browserWindow;

//存放DDPhotoView的数组
@property (nonatomic , strong) NSMutableArray *imagesArray;

@property (nonatomic , strong) UITapGestureRecognizer *singleTapRecognizer;
@property (nonatomic , strong) UITapGestureRecognizer *doubleTapRecognizer;
@property (nonatomic , strong) UILongPressGestureRecognizer *longPressReconizer;

@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) UIView *maskView;

@property (nonatomic , strong) UIPageControl *pageControl;
//
////可复用的PhotoView;
//@property (nonatomic , strong) NSMutableSet *reusePhotoViewSet;

@end

@implementation DDPhotoBrowser

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
    // Do any additional setup after loading the view.
}

- (void)initialize
{
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    ///手势的添加
    
    self.singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    self.singleTapRecognizer.delaysTouchesBegan = YES;
    self.singleTapRecognizer.numberOfTapsRequired = 1;
    
    self.doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    self.doubleTapRecognizer.numberOfTapsRequired = 2;
    [self.singleTapRecognizer requireGestureRecognizerToFail:self.doubleTapRecognizer];
 
    [self.scrollView addGestureRecognizer:self.singleTapRecognizer];
    [self.scrollView addGestureRecognizer:self.doubleTapRecognizer];

    [self.scrollView addGestureRecognizer:self.longPressReconizer];
    
    [self configPhotoView];
}

- (void)configPhotoView
{
    //配置DDPhotoView
    NSInteger count = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numbersOfPhotosInPhotoBrowser:)]) {
        count = [self.dataSource numbersOfPhotosInPhotoBrowser:self];
    }
    
    for(int i = 0; i < count ; i++){
        
        NSString *url = @"";
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(photoBrowser:urlWithPhotoIndex:)]) {
            url = [self.dataSource photoBrowser:self urlWithPhotoIndex:i];
        }
        
        UIImageView *selectView = nil;
        
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(photoBrowser:selectViewWithPhotoIndex:)]) {
            selectView = [self.dataSource photoBrowser:self selectViewWithPhotoIndex:i];
        }
        
        DDPhoto *photo = [DDPhoto new];
        photo.originImageUrl = url;
        photo.selectView = selectView;
        
        DDPhotoView *photoView = [DDPhotoView new];
        photoView.item = photo;
        photoView.frame = CGRectMake(i * [UIScreen mainScreen].bounds.size.width , 0, photoView.bounds.size.width, photoView.bounds.size.height);
        [self.imagesArray addObject:photoView];
        [self.scrollView addSubview:photoView];
    }
    
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * count, 0);
    self.scrollView.contentOffset = CGPointMake(self.currectPhotoIndex * [UIScreen mainScreen].bounds.size.width, 0);
    self.pageControl.numberOfPages = count;
    self.pageControl.currentPage = self.currectPhotoIndex;
}

- (DDPhotoView *)presentPhotoView
{
    DDPhotoView *photoView = [self.imagesArray objectAtIndex:self.currectPhotoIndex];
    return photoView;
}

#pragma mark- Initialize Inteface Methods

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
//        _scrollView.backgroundColor = [UIColor redColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
    }
    return _scrollView;
}

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor blackColor];
    }
    return _maskView;
}

- (UIWindow *)browserWindow
{
    if (!_browserWindow) {
        _browserWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _browserWindow.windowLevel = UIWindowLevelAlert;
        _browserWindow.backgroundColor = [UIColor clearColor];
        _browserWindow.rootViewController = self;
        [_browserWindow addSubview:self.view];
    }
    return _browserWindow;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 40, [UIScreen mainScreen].bounds.size.width , 30)];
        
    }
    return _pageControl;
}

- (NSMutableArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray new];
    }
    return _imagesArray;
}

- (UILongPressGestureRecognizer *)longPressReconizer
{
    if (!_longPressReconizer) {
        _longPressReconizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongTap:)];
    }
    return _longPressReconizer;
}

#pragma mark- Handle GestureRecognizer Methods

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    if ([self presentPhotoView].zoomScale > 1.0) {
        [[self presentPhotoView] setZoomScale:[[self presentPhotoView] minimumZoomScale] animated:YES];
    }else{
        [self hide];
    }
//    [self hide];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)recognizer
{
    DDPhotoView *photoView = [self presentPhotoView];

    CGPoint touchPoint = [recognizer locationInView:photoView];
    if (photoView.zoomScale == photoView.maximumZoomScale) {
        [photoView setZoomScale:photoView.minimumZoomScale animated:YES];
    }else{
        [photoView zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
    }
}

- (void)handleLongTap:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
//            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//            UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//            __weak DDImageBrowser *weakSelf = self;
//            UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                [weakSelf saveImage];
//            }];
//            [actionSheet addAction:act1];
//            [actionSheet addAction:act2];
//            [self presentViewController:actionSheet animated:YES completion:nil];
//        }else{
//            UIActionSheet *longPressActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存", nil];
//            [longPressActionSheet showInView:self.vie];
//        }
    }
}

#pragma mark- UIScrollView Delegate Methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    DDPhotoView *photoView = [self presentPhotoView];
    [photoView setZoomScale:[[self presentPhotoView] minimumZoomScale] animated:YES];
    [self caculateCurrectPhotoIndex:scrollView];

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self caculateCurrectPhotoIndex:scrollView];
}

- (void)caculateCurrectPhotoIndex:(UIScrollView *)scrollView
{
    CGFloat contentOffset = self.scrollView.contentOffset.x;
    CGFloat scrollViewWidth = self.scrollView.frame.size.width;
    self.currectPhotoIndex = contentOffset / scrollViewWidth;
    self.pageControl.currentPage = self.currectPhotoIndex;
}

//#pragma mark- UIActionSheet Delegate Methods
//
//- (void)actionSheet:(nonnull UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 1) {
//        [self saveImage];
//    }
//}
//
//- (void)saveImage
//{
//    
//}

- (void)show
{
    [self.browserWindow makeKeyAndVisible];
    
    [UIApplication sharedApplication].keyWindow.windowLevel = UIWindowLevelStatusBar;
    
    CGRect rect = self.presentPhotoView.imageView.frame;
    
    //如果selectView为空，那么直接淡入，若不为空，则从原图片位置放大淡入至整个屏幕
    if ([[[self presentPhotoView] item] selectView]) {
        self.presentPhotoView.imageView.frame = [[[[self presentPhotoView] item] selectView] convertRect:[[[self presentPhotoView] item] selectView].bounds toView:nil];
    }else{
        self.browserWindow.alpha = 0;
    }
    
    [UIView animateWithDuration:0.35 animations:^{
        self.presentPhotoView.imageView.frame = rect;
//        self.maskView.alpha = 1;
        self.browserWindow.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    
}

- (void)hide
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [UIApplication sharedApplication].keyWindow.windowLevel = UIWindowLevelNormal ;
    
    CGRect rect = [self presentPhotoView].imageView.frame;
    
    //当selectView为空时，那么直接淡出
    if ([[[self presentPhotoView] item] selectView]) {
        rect = [[[[self presentPhotoView] item] selectView] convertRect:[[[self presentPhotoView] item] selectView].bounds toView:nil];
    }
    
    [UIView animateWithDuration:(0.35) animations:^{
        [self presentPhotoView].imageView.frame = rect;
        self.maskView.alpha = 0;
//        self.browserWindow.alpha = 0;
        if (![[[self presentPhotoView] item] selectView]) {
            self.browserWindow.alpha = 0;
        }
    } completion:^(BOOL finished) {
        [self.browserWindow removeFromSuperview];
        [self.scrollView removeFromSuperview];
        self.browserWindow.rootViewController = nil;
        self.browserWindow = nil;
    }];

}

@end

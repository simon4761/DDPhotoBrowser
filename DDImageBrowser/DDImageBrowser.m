//
//  DDImageBrowser.m
//  DDImageBrowser
//
//  Created by Aimeow on 8/4/15.
//  Copyright (c) 2015 Aimeow. All rights reserved.
//

#import "DDImageBrowser.h"

@interface DDImageBrowser () <UIScrollViewDelegate , UIActionSheetDelegate>

@property (nonatomic , strong) UIWindow *browserWindow;

@property (nonatomic , strong) NSMutableArray *imagesArray;

@property (nonatomic , strong) UITapGestureRecognizer *singleTapRecognizer;
@property (nonatomic , strong) UITapGestureRecognizer *doubleTapRecognizer;
//@property (nonatomic , strong) UILongPressGestureRecognizer *longPressReconizer;

@property (nonatomic , assign) NSInteger currectPhotoIndex;
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) UIActivityIndicatorView *indicatorView;

@end

@implementation DDImageBrowser

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
    // Do any additional setup after loading the view.
}

- (void)initialize
{
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.indicatorView];
    ///手势的添加
    [self.scrollView addGestureRecognizer:self.singleTapRecognizer];
    [self.scrollView addGestureRecognizer:self.doubleTapRecognizer];
//    [self.scrollView addGestureRecognizer:self.longPressReconizer];
}

- (void)show
{
    [self.browserWindow makeKeyAndVisible];
//    [self showAnimation:self.browserWindow];
    
    [UIView animateWithDuration:0.25 animations:^{
//        self.maskView.alpha = 1.0;
    }];
}

- (void)dismiss
{
//    [self dismissAnimation:self.contentView];
    [UIView animateWithDuration:(0.2) animations:^{
        self.browserWindow.alpha = 0;
        self.browserWindow.alpha = 0;
    } completion:^(BOOL finished) {
        [self.browserWindow removeFromSuperview];
        self.browserWindow.rootViewController = nil;
        self.browserWindow = nil;
        //        [self.mainWindow makeKeyAndVisible];
    }];
}

#pragma mark- Setter Methods

- (void)setPhotosArray:(NSMutableArray *)photosArray
{
    _photosArray = photosArray;
    for (DDPhotoView *photoView in photosArray) {
        
    }
}

- (DDPhotoView *)presentPhotoView
{
    DDPhotoView *photoView = [self.imagesArray objectAtIndex:self.currectPhotoIndex];
    return photoView;
}

#pragma mark- Initialize Inteface Methods

- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
    }
    return _scrollView;
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

- (UITapGestureRecognizer *)singleTapRecognizer
{
    if (!_singleTapRecognizer) {
        _singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        _singleTapRecognizer.delaysTouchesBegan = YES;
        _singleTapRecognizer.numberOfTapsRequired = 1;
    }
    return _singleTapRecognizer;
}

- (UITapGestureRecognizer *)doubleTapRecognizer
{
    if (!_doubleTapRecognizer) {
        _doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        _doubleTapRecognizer.numberOfTapsRequired = 2;
    }
    return _singleTapRecognizer;
}

//- (UILongPressGestureRecognizer *)longPressReconizer
//{
//    if (!_longPressReconizer) {
//        _longPressReconizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongTap:)];
//    }
//    return _longPressReconizer;
//}

#pragma mark- Handle GestureRecognizer Methods

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self dismiss];
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

//- (void)handleLongTap:(UITapGestureRecognizer *)recognizer
//{
//    if (recognizer.state == UIGestureRecognizerStateBegan) {
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
//    }
//}

#pragma mark- UIScrollView Delegate Methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    DDPhotoView *photoView = [self presentPhotoView];
    [photoView setZoomScale:[[self presentPhotoView] minimumZoomScale] animated:YES];
    CGFloat contentOffset = self.scrollView.contentOffset.x;
    CGFloat scrollViewWidth = self.scrollView.frame.size.width;
    self.currectPhotoIndex = contentOffset / scrollViewWidth;

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
@end

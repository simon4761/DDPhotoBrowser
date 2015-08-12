//
//  DDPhotoView.m
//  DDImageBrowser
//
//  Created by Aimeow on 8/4/15.
//  Copyright (c) 2015 Aimeow. All rights reserved.
//

#import "DDPhotoView.h"
#import <SDWebImageManager.h>

@interface DDPhotoView ()<UIScrollViewDelegate>{
    UIActivityIndicatorView *_activityView;
}

@end

@implementation DDPhotoView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (self) {
        _imageView = UIImageView.new;
        _imageView.frame = [[UIScreen mainScreen] bounds];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityView.center = self.center;
        [self addSubview:_activityView];
        _activityView.hidden = YES;
        
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self setUserInteractionEnabled:YES];
        
        self.scrollEnabled = NO;
    }
    return self;
}

- (void)startAnimation{
    _activityView.hidden = NO;
    [_activityView startAnimating];
}

- (void)stopAnimation{
    _activityView.hidden = YES;
    [_activityView stopAnimating];
}

- (void)setItem:(DDPhoto *)item{
    _item = item;
    
    [self startAnimation];
    
    if ([item.selectView isKindOfClass:[UIImageView class]]) {
        if (item.selectView.image) {
            self.imageView.image = item.selectView.image;
        }
    }
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:item.originImageUrl] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
   
        [self.imageView setImage:image];
        [self stopAnimation];
        
        [self updateImgViewFrameAfterImageSet];
        
        CATransition *animation = [CATransition animation];
        [animation setType:kCATransitionFade];
        [animation setDuration:0.15f];
        [animation setRemovedOnCompletion:YES];
        [_imageView.layer addAnimation:animation forKey:@"fade"];
        
        self.scrollEnabled = YES;
    }];
}

- (void)updateImgViewFrameAfterImageSet
{
    if (_imageView.image == nil) {
        return;
    }
    CGSize size = [self validImageSize:_imageView.image];
    _imageView.frame = CGRectMake(0, 0, size.width, size.height);
    _imageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    [self setMaxZoomScalesForCurrentBounds];
}

- (CGSize)validImageSize:(UIImage *)imageToShow
{
    CGFloat width = imageToShow.size.width/[UIScreen mainScreen].scale;
    CGFloat height = imageToShow.size.height/[UIScreen mainScreen].scale;

    if (width/height>self.frame.size.width/self.frame.size.height) {
        height = self.frame.size.width*height/width;
        width = self.frame.size.width;
    }else {
        width = width*self.frame.size.height/height;
        height = self.frame.size.height;
    }
    
    return CGSizeMake(width, height);
}

- (void)setMaxZoomScalesForCurrentBounds {
    CGSize boundsSize = self.bounds.size;
    CGSize imageSize = _imageView.bounds.size;
    
    CGFloat xScale = boundsSize.width / imageSize.width;
    CGFloat yScale = boundsSize.height / imageSize.height;
    CGFloat maxScale = MAX(MAX(xScale, yScale), 2.0);
    
    self.maximumZoomScale = maxScale;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    _imageView.frame = CGRectMake(floor((MAX(scrollView.contentSize.width, scrollView.frame.size.width)-_imageView.frame.size.width)/2),
                                  floor((MAX(scrollView.contentSize.height, scrollView.frame.size.height)-_imageView.frame.size.height)/2),
                                  _imageView.frame.size.width,
                                  _imageView.frame.size.height);
}

@end

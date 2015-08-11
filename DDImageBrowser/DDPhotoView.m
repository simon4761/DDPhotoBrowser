//
//  DDPhotoView.m
//  DDImageBrowser
//
//  Created by Aimeow on 8/4/15.
//  Copyright (c) 2015 Aimeow. All rights reserved.
//

#import "DDPhotoView.h"

@interface DDPhotoView()<UIScrollViewDelegate>

@property (nonatomic , strong) UIImageView *imageView;

@end

@implementation DDPhotoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.userInteractionEnabled = YES;
        self.scrollEnabled = NO;
        [self addSubview:self.imageView];
    }
    return self;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (void)setPhoto:(DDPhoto *)photo
{
    _photo = photo;
}

#pragma mark- UIScrollView Delegate Methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.imageView.frame = CGRectMake(floor((fmax(scrollView.contentSize.width, scrollView.frame.size.width) - self.imageView.frame.size.width)/2), floor((fmax(scrollView.contentSize.height, scrollView.frame.size.height)-self.imageView.frame.size.height)/2), self.imageView.frame.size.width, self.imageView.frame.size.height);
}


//func setNewPhoto(photo : ImageEntity)
//{
//    self.photo = photo
//    imageView.image = photo.placeHolder
//    photoViewDelegate?.AmPhotoImageDidStartLoad?(self)
//    SDWebImageManager.sharedManager().downloadImageWithURL(NSURL(string: photo.bigPicUrl!) , options: SDWebImageOptions.RefreshCached, progress: { (receivedSize : Int,  expectedSize : Int) -> Void in
//        
//    }) { (image : UIImage!, error : NSError!, cacheType : SDImageCacheType, finished : Bool, imageURL : NSURL!) -> Void in
//        self.photoViewDelegate?.AmPhotoImageDidFinishLoad?(self)
//        self.imageView.image = image
//        photo.placeHolder = image
//        self.scrollEnabled = true
//        self.adjustFrame()
//    }
//}
//
//func adjustFrame()
//{
//    if self.imageView.image != nil
//    {
//        self.imageView.height = self.bounds.size.width / self.imageView.image!.size.width*self.imageView.image!.size.height
//    }
//    self.imageView.width = self.bounds.size.width
//    
//    if(self.imageView.height>=self.bounds.size.height){
//        self.imageView.top = 0;
//    }
//    else{
//        self.imageView.top = self.bounds.size.height/2 -  self.imageView.height/2
//    }
//    
//    var maxScale : CGFloat = 2.0
//    self.maximumZoomScale = maxScale
//}

@end

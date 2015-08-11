//
//  DDPhotoView.h
//  DDImageBrowser
//
//  Created by Aimeow on 8/4/15.
//  Copyright (c) 2015 Aimeow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPhoto.h"

@class DDPhotoView;
//@protocol  DDPhotoViewDelegate <NSObject>
//
//- (void)itemImageDidStartLoad : (DDPhotoView *)itemView;
//- (void)itemImageDidFinishLoad : (DDPhotoView *)itemView;
//
//@end

@interface DDPhotoView : UIScrollView

@property (nonatomic, strong)DDPhoto *item;
@property (nonatomic, strong)UIImageView *imageView;
//@property (nonatomic)id<DDPhotoViewDelegate> itemDelegate;

//- (void)startAnimation;
//- (void)stopAnimation;

@end

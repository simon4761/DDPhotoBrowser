//
//  DDImageBrowser.h
//  DDImageBrowser
//
//  Created by Aimeow on 8/4/15.
//  Copyright (c) 2015 Aimeow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPhotoView.h"

@interface DDPhotoBrowser : UIViewController

///存放DDPhoto的数组
@property (nonatomic , strong) NSMutableArray *photosArray;
@property (nonatomic , assign) NSInteger currectPhotoIndex;

- (id)initWithPhotosArray:(NSArray *)photosArray;

- (void)show;
- (void)hide;

@end

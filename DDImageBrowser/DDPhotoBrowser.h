//
//  DDImageBrowser.h
//  DDImageBrowser
//
//  Created by Aimeow on 8/4/15.
//  Copyright (c) 2015 Aimeow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPhotoView.h"

@class DDPhotoBrowser;

@protocol DDPhotoBrowserDataSource <NSObject>

- (NSInteger)numbersOfPhotosInPhotoBrowser:(DDPhotoBrowser *)photoBrowser;
- (NSString *)photoBrowser:(DDPhotoBrowser *)photoBrowser urlWithPhotoIndex:(NSInteger)index;
- (UIImageView *)photoBrowser:(DDPhotoBrowser *)photoBrowser selectViewWithPhotoIndex:(NSInteger)index;

@end

@interface DDPhotoBrowser : UIViewController

@property (nonatomic , assign) NSInteger currectPhotoIndex;
@property (nonatomic) id<DDPhotoBrowserDataSource> dataSource;

- (void)show;
- (void)hide;

@end

//
//  DDPhoto.h
//  DDImageBrowser
//
//  Created by Aimeow on 8/6/15.
//  Copyright (c) 2015 Aimeow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DDPhoto : NSObject

@property (nonatomic , strong) NSString *originImageUrl;
//@property (nonatomic , strong) NSString *bigImageUrl;
//@property (nonatomic , strong) UIImageView *holder;
@property (nonatomic , strong) UIImageView *selectView;

- (id)initWithOriginImageUrl:(NSString *)originImageUrl;
- (id)initWithOriginImageUrl:(NSString *)originImageUrl withSelectView:(UIImageView *)selectView;

@end
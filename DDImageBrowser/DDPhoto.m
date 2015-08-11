//
//  DDPhoto.m
//  DDImageBrowser
//
//  Created by Aimeow on 8/6/15.
//  Copyright (c) 2015 Aimeow. All rights reserved.
//

#import "DDPhoto.h"

@implementation DDPhoto

- (id)initWithOriginImageUrl:(NSString *)originImageUrl
{
    return [self initWithOriginImageUrl:originImageUrl withSelectView:nil];
}

- (id)initWithOriginImageUrl:(NSString *)originImageUrl withSelectView:(UIImageView *)selectView
{
    self = [super init];
    if (self) {
        self.originImageUrl = originImageUrl;
        self.selectView = selectView;
    }
    return self;
}

@end

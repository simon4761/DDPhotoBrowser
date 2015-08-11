//
//  ViewController2.m
//  DDImageBrowser
//
//  Created by Aimeow on 8/11/15.
//  Copyright (c) 2015 Aimeow. All rights reserved.
//

#import "ViewController2.h"
#import <UIImageView+WebCache.h>
#import "DDPhotoBrowser.h"

@interface ViewController2 ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView5;
@property (weak, nonatomic) IBOutlet UIImageView *imageView6;
@property (weak, nonatomic) IBOutlet UIImageView *imageView7;
@property (nonatomic , strong) NSArray *imageArray;
@property (nonatomic , strong) NSArray *photoArray;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArray = @[@"http://e.hiphotos.baidu.com/image/h%3D200/sign=e705840faf64034f10cdc5069fc17980/63d0f703918fa0eca4042edf229759ee3c6ddb25.jpg" , @"http://h.hiphotos.baidu.com/image/pic/item/9e3df8dcd100baa1f20df3564310b912c8fc2e3d.jpg" , @"http://c.hiphotos.baidu.com/image/pic/item/e824b899a9014c08ec4e87b8087b02087bf4f4b2.jpg" , @"http://f.hiphotos.baidu.com/image/pic/item/b3119313b07eca80f01cc238952397dda04483d0.jpg" , @"http://d.hiphotos.baidu.com/image/pic/item/908fa0ec08fa513d55bfe028386d55fbb2fbd92b.jpg" , @"http://b.hiphotos.baidu.com/image/pic/item/622762d0f703918f31819069543d269758eec4c5.jpg" , @"http://a.hiphotos.baidu.com/image/pic/item/d53f8794a4c27d1ef288a0131fd5ad6edcc438be.jpg" , @"http://h.hiphotos.baidu.com/image/pic/item/d439b6003af33a870e8b4192c45c10385243b550.jpg" , @"http://h.hiphotos.baidu.com/image/pic/item/b812c8fcc3cec3fd03225868d488d43f8794278b.jpg"];
    
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:[self.imageArray objectAtIndex:0]]];
    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:[self.imageArray objectAtIndex:1]]];
    [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:[self.imageArray objectAtIndex:2]]];
    [self.imageView4 sd_setImageWithURL:[NSURL URLWithString:[self.imageArray objectAtIndex:3]]];
    [self.imageView5 sd_setImageWithURL:[NSURL URLWithString:[self.imageArray objectAtIndex:4]]];
    [self.imageView6 sd_setImageWithURL:[NSURL URLWithString:[self.imageArray objectAtIndex:5]]];
    [self.imageView7 sd_setImageWithURL:[NSURL URLWithString:[self.imageArray objectAtIndex:6]]];
    
    UITapGestureRecognizer *recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
    UITapGestureRecognizer *recognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
    UITapGestureRecognizer *recognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
    UITapGestureRecognizer *recognizer4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
    UITapGestureRecognizer *recognizer5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
    UITapGestureRecognizer *recognizer6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
    UITapGestureRecognizer *recognizer7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
    
    [self.imageView1 setUserInteractionEnabled:YES];
    [self.imageView2 setUserInteractionEnabled:YES];
    [self.imageView3 setUserInteractionEnabled:YES];
    [self.imageView4 setUserInteractionEnabled:YES];
    [self.imageView5 setUserInteractionEnabled:YES];
    [self.imageView6 setUserInteractionEnabled:YES];
    [self.imageView7 setUserInteractionEnabled:YES];
    
    [self.imageView1 addGestureRecognizer:recognizer1];
    [self.imageView2 addGestureRecognizer:recognizer2];
    [self.imageView3 addGestureRecognizer:recognizer3];
    [self.imageView4 addGestureRecognizer:recognizer4];
    [self.imageView5 addGestureRecognizer:recognizer5];
    [self.imageView6 addGestureRecognizer:recognizer6];
    [self.imageView7 addGestureRecognizer:recognizer7];
    
    self.imageView1.tag = 1001;
    self.imageView2.tag = 1002;
    self.imageView3.tag = 1003;
    self.imageView4.tag = 1004;
    self.imageView5.tag = 1005;
    self.imageView6.tag = 1006;
    self.imageView7.tag = 1007;
    
    self.photoArray = @[self.imageView1 , self.imageView2 , self.imageView3 , self.imageView4 , self.imageView5 , self.imageView6 , self.imageView7];
    // Do any additional setup after loading the view.
}

- (void)clicked:(UITapGestureRecognizer *)recognizer
{
    NSInteger index = recognizer.view.tag - 1001;
    DDPhotoBrowser *photoBrowser = [DDPhotoBrowser new];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < self.photoArray.count; i ++) {
        DDPhoto *photo = [[DDPhoto alloc] init];
        photo.originImageUrl = [self.imageArray objectAtIndex:i];
        photo.selectView = [self.photoArray objectAtIndex:i];
        [array addObject:photo];
    }

    photoBrowser.currectPhotoIndex = index;
    photoBrowser.photosArray = array;
    [photoBrowser show];
}

@end

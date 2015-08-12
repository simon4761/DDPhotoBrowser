//
//  ViewController.m
//  DDImageBrowser
//
//  Created by Aimeow on 8/4/15.
//  Copyright (c) 2015 Aimeow. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+WebCache.h>
#import "DDPhotoBrowser.h"

@interface ViewController () <DDPhotoBrowserDataSource>

@property (nonatomic , strong) NSArray *imageArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArray = @[@"http://e.hiphotos.baidu.com/image/h%3D200/sign=e705840faf64034f10cdc5069fc17980/63d0f703918fa0eca4042edf229759ee3c6ddb25.jpg" , @"http://h.hiphotos.baidu.com/image/pic/item/9e3df8dcd100baa1f20df3564310b912c8fc2e3d.jpg" , @"http://c.hiphotos.baidu.com/image/pic/item/e824b899a9014c08ec4e87b8087b02087bf4f4b2.jpg" , @"http://f.hiphotos.baidu.com/image/pic/item/b3119313b07eca80f01cc238952397dda04483d0.jpg" , @"http://d.hiphotos.baidu.com/image/pic/item/908fa0ec08fa513d55bfe028386d55fbb2fbd92b.jpg" , @"http://b.hiphotos.baidu.com/image/pic/item/622762d0f703918f31819069543d269758eec4c5.jpg" , @"http://a.hiphotos.baidu.com/image/pic/item/d53f8794a4c27d1ef288a0131fd5ad6edcc438be.jpg" , @"http://h.hiphotos.baidu.com/image/pic/item/d439b6003af33a870e8b4192c45c10385243b550.jpg" , @"http://h.hiphotos.baidu.com/image/pic/item/b812c8fcc3cec3fd03225868d488d43f8794278b.jpg"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCellIdentifier" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:[self.imageArray objectAtIndex:indexPath.row]] placeholderImage:nil];
//    imageView.image = [UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.row]];
    [cell addSubview:imageView];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDPhotoBrowser *photoBrowser = [DDPhotoBrowser new];
    photoBrowser.dataSource = self;
    photoBrowser.currectPhotoIndex = indexPath.row;
    [photoBrowser show];
}

- (NSString *)photoBrowser:(DDPhotoBrowser *)photoBrowser urlWithPhotoIndex:(NSInteger)index
{
    return [self.imageArray objectAtIndex:index];
}

- (NSInteger)numbersOfPhotosInPhotoBrowser:(DDPhotoBrowser *)photoBrowser
{
    return self.imageArray.count;
}

-(UIImageView *)photoBrowser:(DDPhotoBrowser *)photoBrowser selectViewWithPhotoIndex:(NSInteger)index
{
    return nil;
}

@end

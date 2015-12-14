//
//  SnapshoImageView.m
//  JJCollectionView
//
//  Created by Mac on 15/12/2.
//  Copyright © 2015年 DJJ. All rights reserved.
//

#import "JJSnapshoImageView.h"

@implementation JJSnapshoImageView

+ (UIImageView *) customSnapshoFromView:(UIView *) view
{
    //获取传进来的view的截图
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    //初始化一个imageview，并设置阴影
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.layer.shadowOffset = CGSizeMake(-5.0, 0.0); //设置阴影的偏移量
    imageView.layer.shadowRadius = 5.0;//设置阴影半径
    imageView.layer.shadowOpacity = 0.4;//设置阴影透明度

    return imageView;
}

@end

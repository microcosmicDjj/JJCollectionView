//
//  SnapshoImageView.h
//  JJCollectionView
//
//  Created by Mac on 15/12/2.
//  Copyright © 2015年 DJJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JJSnapshoImageView : NSObject

/**
 * MARK:拿到一个view的截图转成imageView
 */
+ (UIImageView *) customSnapshoFromView:(UIView *) view;

@end

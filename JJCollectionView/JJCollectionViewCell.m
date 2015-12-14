//
//  JJCollectionViewCell.m
//  JJCollectionView
//
//  Created by Mac on 15/11/30.
//  Copyright © 2015年 DJJ. All rights reserved.
//

#import "JJCollectionViewCell.h"

@implementation JJCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"JJCollectionViewCell" owner:self options:nil];
        if(arrayOfViews.count < 1){
            return nil;
        }
        if (![arrayOfViews[0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        self = arrayOfViews[0];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

@end

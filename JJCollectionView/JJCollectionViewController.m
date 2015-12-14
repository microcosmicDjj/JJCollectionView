//
//  JJCollectionViewController.m
//  JJCollectionView
//
//  Created by Mac on 15/11/30.
//  Copyright © 2015年 DJJ. All rights reserved.
//

#import "JJCollectionViewController.h"
#import "JJCollectionViewCell.h"
#import "JJSnapshoImageView.h"

@interface JJCollectionViewController ()
/** 数据源**/
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation JJCollectionViewController

static NSString * const reuseIdentifier = @"JJCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerClass:[JJCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor grayColor];
    
    //设置手势
    UILongPressGestureRecognizer *longPressCollectionView = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressCollectionView:)];
    [self.collectionView addGestureRecognizer:longPressCollectionView];
}

/*
 *  MARK:长按手势响应方法
 */
- (void) longPressCollectionView:(UILongPressGestureRecognizer *) longPressCollectionView
{
    //如果不是静态的会导致第二次调用之后，拿到的 snapsImageView 和 snapsIndexPath为空或者其它值，也可以写成全局的变量
    static UIImageView *snapsImageView = nil;
    static NSIndexPath *snapsIndexPath = nil;
    
    //获取点按的位置
    CGPoint location = [longPressCollectionView locationInView:self.collectionView];
    //获取点中cell的索引
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];

    switch (longPressCollectionView.state) {
        case UIGestureRecognizerStateBegan://手势开始的时候
        {
            if (indexPath) {
                //将拿到的cell的索引赋值给snapsIndexPath
                snapsIndexPath = indexPath;
                //通过snapsIndexPath拿到相对应的cell
                JJCollectionViewCell *cell = (JJCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:snapsIndexPath];
                //从cell截取一个imageview
                snapsImageView = [JJSnapshoImageView customSnapshoFromView:cell.contentView];
                //获取点击的y值，方便在block中使用
                __block CGFloat cellY = location.y;
                //将cell的起点赋值给snapsImageView
                snapsImageView.center = cell.center;
                    
                [self.collectionView addSubview:snapsImageView];
                
                //开启动画
                [UIView animateWithDuration:.3 animations:^{
                    snapsImageView.center = CGPointMake(snapsImageView.center.x, cellY);
                    snapsImageView.alpha = .8f;
                    cell.contentView.hidden = YES;
                }];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:  //当手指移动时
        {
            //拖动事件
            snapsImageView.center = location;
            
            if (indexPath && ![indexPath isEqual:snapsIndexPath]) {
                //将snapsIndexPath 移动到indexPath上
                [self.collectionView moveItemAtIndexPath:snapsIndexPath toIndexPath:indexPath];
                //对应的self.datas 也要变化
                [self.datas exchangeObjectAtIndex:snapsIndexPath.row withObjectAtIndex:indexPath.row];
                snapsIndexPath = indexPath;
            }

        }
            break;
        case UIGestureRecognizerStateEnded: //当手指离开屏幕时
        {
            JJCollectionViewCell *cell = (JJCollectionViewCell *)[self.collectionView
                                                                  cellForItemAtIndexPath:snapsIndexPath];
            [UIView animateWithDuration:.3 animations:^{
                //snapsImageView的中心点等于所截取的cell的中心点
                snapsImageView.center = cell.center;
            } completion:^(BOOL finished) {
                //从屏幕上移除
                [snapsImageView removeFromSuperview];
                cell.contentView.hidden = NO;
                //释放掉
                snapsImageView = nil;
                snapsIndexPath = nil;
            }];
        
        }
            break;
        default:
            break;
    }

}

/*
 *  MARK:collectionView 代理
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.tilteLabel.text = self.datas[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"qq.jpg"];

    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets indets = UIEdgeInsetsMake(10, 10, 10, 10);
    return indets;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rect = [UIScreen mainScreen].bounds;
    
    return CGSizeMake((rect.size.width - 30)/2,(rect.size.width - 30)/2);
}

/*
 * MARK: 懒加载
 */
- (NSMutableArray *) datas
{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] initWithObjects:@"第1个",@"第2个",@"第3个",@"第4个",@"第5个",@"第6个",@"第7个",@"第8个",@"第9个",@"第10个",@"第11个",@"第12个", nil];
    }
    return _datas;
}

@end

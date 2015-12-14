//
//  ViewController.m
//  JJCollectionView
//
//  Created by Mac on 15/11/30.
//  Copyright © 2015年 DJJ. All rights reserved.
//

#import "ViewController.h"
#import "JJCollectionViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnTouch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_btnTouch setTitle:@"点击进入click rate" forState:UIControlStateNormal];
}

- (IBAction)btnTouch:(id)sender {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    JJCollectionViewController *jjColletionVC = [[JJCollectionViewController alloc] initWithCollectionViewLayout:layout];
    [self presentViewController:jjColletionVC animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

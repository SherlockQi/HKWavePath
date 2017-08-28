//
//  ViewController.m
//  WaveDemo
//
//  Created by hosa on 2017/8/28.
//  Copyright © 2017年 Heikki. All rights reserved.
//

#import "ViewController.h"

#import "HKWavePath.h"

@interface ViewController ()<HKWavePathDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    HKWaveView *waveView =[[HKWaveView alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:waveView];

    HKWavePath *wavePath = [HKWavePath wavePathWithFrame:self.imageView.bounds];
    
    
    wavePath.delegate = self;
    
    
}

-(void)wavePath:(HKWavePath *)wave didComplete:(UIBezierPath *)path{
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = path.CGPath;
    self.imageView.layer.mask = maskLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

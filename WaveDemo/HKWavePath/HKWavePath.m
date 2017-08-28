//
//  HKWavePath.m
//  WaveDemo
//
//  Created by hosa on 2017/8/28.
//  Copyright © 2017年 Heikki. All rights reserved.
//

#import "HKWavePath.h"
@interface HKWavePath()

@property (nonatomic, assign) CGRect frame;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat presentX;
@property (nonatomic, assign) CGFloat presentY;
@end
@implementation HKWavePath
+ (instancetype)wavePathWithFrame:(CGRect)frame{
    HKWavePath *path = [[HKWavePath alloc]init];
    path.frame = frame;
    return path;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self creatPath];
        self.amplitude = 10;
        self.rate = 0.02;
        self.defaultY = 180;
        
        [self startAnimation];

    }
    return self;
}

- (void)creatPath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 100)];
    
    /**
     
     正弦型函数解析式：y=Asin（ωx+φ）+h
     各常数值对函数图像的影响：
     φ（初相位）：决定波形与X轴位置关系或横向移动距离（左加右减）
     ω：决定周期（最小正周期T=2π/|ω|）
     A：决定峰值（即纵向拉伸压缩的倍数）
     h：表示波形在Y轴的位置关系或纵向移动距离（上加下减）
     
     */
    CGFloat A = self.amplitude;
    CGFloat ω = self.rate;
    CGFloat φ = self.presentX;
    CGFloat k = self.defaultY+self.presentY;
    [path moveToPoint:CGPointMake(0, k)];
    for(int j = 0; j < self.frame.size.width; j++) {
        CGFloat y = A * sin(ω * j + φ) + k;
        [path addLineToPoint:CGPointMake(j , y)];
        NSLog(@"%d------%f",j,y);
    }
    [path addLineToPoint:CGPointMake(self.frame.size.width, k)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path closePath];
    
    if ([self.delegate respondsToSelector:@selector(wavePath:didComplete:)]) {
        [self.delegate wavePath:self didComplete:path];
    }
}


-(CADisplayLink *)displayLink{
    if (_displayLink == nil) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(startAnimation)];
        _displayLink.preferredFramesPerSecond = 60;
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _displayLink;
}
/**
 开始波动
 */
- (void)startAnimation {
    [self stopAnimation];
    self.displayLink.paused = NO;
    self.presentX += 0.1;
    self.presentY -= 0.3;
    [self creatPath];
    // 每次0.05秒执行一次动画
}
/**
 停止波动
 */
- (void)stopAnimation {
    self.displayLink.paused = YES;
    [self.displayLink invalidate];
    self.displayLink = nil;
}

@end

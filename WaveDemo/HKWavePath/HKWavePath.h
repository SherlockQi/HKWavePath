//
//  HKWavePath.h
//  WaveDemo
//
//  Created by hosa on 2017/8/28.
//  Copyright © 2017年 Heikki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HKWavePath;
@protocol HKWavePathDelegate <NSObject>
- (void)wavePath:(HKWavePath *)wave didComplete:(UIBezierPath *)path;
@end
@interface HKWavePath : NSObject
///波浪的 Y
@property (nonatomic, assign) CGFloat defaultY;
///波浪的垂直上升速度
@property (nonatomic, assign) CGFloat speedY;
///波浪的水平移动速度
@property (nonatomic, assign) CGFloat speedX;
///振幅
@property (nonatomic, assign) CGFloat amplitude;
///频率
@property (nonatomic, assign) CGFloat rate;

@property (nonatomic, weak) id<HKWavePathDelegate> delegate;
+ (instancetype)wavePathWithFrame:(CGRect)frame;

@end

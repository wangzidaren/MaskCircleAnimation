//
//  ViewController.m
//  MaskCircleAnimation
//
//  Created by tracy on 15-1-10.
//  Copyright (c) 2015年 tracy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


#define animationtoValue 2.5f
#define animationfromValue 0.25f
#define animationDuration 1.0f


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self initUI];
    
}


-(void) initUI
{
    
    //第一个view
    UIView *_colorView=[[UIView alloc] init];
    _colorView.frame=self.view.frame;
    _colorView.backgroundColor=[UIColor colorWithRed:0.0/25.0 green:187.0/255.0 blue:211.0/255.0 alpha:1];
    [self.view addSubview:_colorView];
    
    //第二个view,放在第一个view下面
    UIImageView *imageView=[[UIImageView alloc] init];
    imageView.frame=self.view.frame;
    imageView.image=[UIImage imageNamed:@"bg.png"];
    [self.view addSubview:imageView];
    
    //创建一个cashapelayer，用来绘制圆
    CAShapeLayer *circleMaskLayer = [CAShapeLayer layer];
    circleMaskLayer.frame = self.view.bounds;
    
    
    CGFloat diameter = MIN(self.view.bounds.size.height, self.view.bounds.size.width);
    //半径
    CGFloat radius = diameter / 2;
    
    //圆心
    CGPoint circleCenter = CGPointMake(_colorView.bounds.origin.x + _colorView.bounds.size.width / 2,
                                       _colorView.bounds.origin.y + _colorView.bounds.size.height / 2);
    
    
    circleMaskLayer.position = circleCenter;
    CGRect circleBoundingRect = CGRectMake(circleCenter.x - radius, circleCenter.y - radius, 2.0*radius, 2.0*radius);
    //贝塞尔创建圆的路径
    circleMaskLayer.path = [UIBezierPath bezierPathWithOvalInRect:circleBoundingRect].CGPath;
    circleMaskLayer.bounds = circleBoundingRect;
    
    //创建缩放动画
    CABasicAnimation *circleMaskAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    circleMaskAnimation.duration =animationDuration;
    circleMaskAnimation.repeatCount = 1;
    circleMaskAnimation.removedOnCompletion = NO;
    
    //functionWithControlPoints:是一个贝塞尔曲线的控制方法。 这也可以令动画做到先慢后快或先快后慢的结果
    [circleMaskAnimation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.34 :.01 :.69 :1.37]];
    
    [circleMaskAnimation setFillMode:kCAFillModeForwards];
    circleMaskAnimation.fromValue = [NSNumber numberWithFloat:animationfromValue];
    circleMaskAnimation.toValue   = [NSNumber numberWithFloat:animationtoValue];
    //设置遮罩层
    [imageView.layer setMask:circleMaskLayer];
    imageView.layer.masksToBounds = YES;
    [circleMaskLayer addAnimation:circleMaskAnimation forKey:@"myMaskAnimation"];
    
    
    
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


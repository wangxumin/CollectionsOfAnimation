//
//  CABasicAnimationViewController.m
//  CollectionsOfAnimation
//
//  Created by 王续敏 on 17/1/10.
//  Copyright © 2017年 wangxumin. All rights reserved.
//

#import "CABasicAnimationViewController.h"

@interface CABasicAnimationViewController ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIView *centerView;
@end

@implementation CABasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//组动画
- (IBAction)AnimationOne:(UIButton *)sender {
    if ([self.centerView.layer animationKeys].count > 0) {
        [self.centerView.layer removeAllAnimations];
    }
    //位移
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(150, 300)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(120, 200)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
    NSValue *value6 = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
    NSValue *value7 = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    keyAnimation.values = @[value1,value2,value3,value4,value5,value6,value7];
    
    //缩放
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimation.fromValue = @0.5;//初始大小，为正常大小的0.5倍
    basicAnimation.toValue = @1.0;//最终大小
    basicAnimation.duration = 0.5;//持续时间
    basicAnimation.repeatCount = MAXFLOAT;//重复次数
    basicAnimation.autoreverses = YES;//是不是执行可逆动画
    
    //    旋转动画
    CABasicAnimation *basicRoatatiton = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    basicRoatatiton.toValue = @(M_PI*4);
    basicRoatatiton.duration = 0.1;
    basicRoatatiton.repeatCount = MAXFLOAT;
    basicRoatatiton.timingFunction = [CAMediaTimingFunction functionWithName:kCAAnimationLinear];//动画过度效果
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[keyAnimation,basicAnimation,basicRoatatiton];
    groupAnimation.repeatCount = 1;
    groupAnimation.duration = 1.0;
    [self.centerView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
}
//按时间，顺序执行的组动画
- (IBAction)AnimationTwo:(UIButton *)sender {
    if ([self.centerView.layer animationKeys].count > 0) {
        [self.centerView.layer removeAllAnimations];
    }
    CFTimeInterval currentTime = CACurrentMediaTime();
    //位移动画
    CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"position"];
    anima1.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 200)];
    anima1.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 250)];
    anima1.beginTime = currentTime;
    anima1.duration = 1.0f;
    anima1.fillMode = kCAFillModeForwards;
    anima1.removedOnCompletion = NO;//动画执行完毕是不是从当前图层移除,不能跟autoreverses同时使用
    [self.centerView.layer addAnimation:anima1 forKey:@"aa"];
    
    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    anima2.beginTime = currentTime+1.0f;
    anima2.duration = 1.0f;
    anima2.fillMode = kCAFillModeForwards;
    anima2.removedOnCompletion = NO;
    [self.centerView.layer addAnimation:anima2 forKey:@"bb"];
    
    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    anima3.beginTime = currentTime+2.0f;
    anima3.duration = 1.0f;
    anima3.fillMode = kCAFillModeForwards;
    anima3.removedOnCompletion = NO;
    [self.centerView.layer addAnimation:anima3 forKey:@"cc"];
}
- (IBAction)animationThreeAction:(UIButton *)sender {
    if ([self.centerView.layer animationKeys].count > 0) {
        [self.centerView.layer removeAllAnimations];
    }
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 2.0;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.centerView.center.x, self.centerView.center.y)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.centerView.center.x, self.centerView.center.y + 100)];
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    //存储当前位置在动画结束后使用
    [animation setValue:[NSValue valueWithCGPoint:CGPointMake(self.centerView.center.x, self.centerView.center.y + 100)]forKey:@"KCBasicAnimationLocation"];
     //存储当前位置在动画结束后使用
    [self.centerView.layer addAnimation:animation forKey:@"basicAnimation"];
    
    //这个动画执行完毕，会出现一下子跳到原来位置的现象，因为图层动画的本质就是将图层内部的内容转化为位图经硬件操作形成一种动画效果，其实图层本身并没有任何的变化,这里为了避免出现这种情况，需要在动画执行完毕之后重新设置下他的位置
}
#pragma mark ====CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"%@",anim);
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//    //开启事物
    [CATransaction begin];
//    //禁用隐式动画
    [CATransaction setDisableActions:YES];
    self.centerView.layer.position = [[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue];
    //提交事物
    [CATransaction commit];
}

//根据规划路径播放动画
- (IBAction)AnimationFour:(UIButton *)sender {
    if ([self.centerView.layer animationKeys].count > 0) {
        [self.centerView.layer removeAllAnimations];
    }
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint endPoint= CGPointMake(55, 400);
    CGPathMoveToPoint(path, NULL, self.centerView.layer.position.x, self.centerView.layer.position.y);
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, endPoint.x, endPoint.y);
    keyAnimation.path = path;
    CGPathRelease(path);
    keyAnimation.duration = 2.0;
    keyAnimation.fillMode = kCAFillModeForwards;
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.centerView.layer addAnimation:keyAnimation forKey:@"keyPathAnimation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

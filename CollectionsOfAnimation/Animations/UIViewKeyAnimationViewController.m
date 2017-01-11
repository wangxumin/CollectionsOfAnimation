//
//  UIViewKeyAnimationViewController.m
//  CollectionsOfAnimation
//
//  Created by 王续敏 on 17/1/10.
//  Copyright © 2017年 wangxumin. All rights reserved.
//

#import "UIViewKeyAnimationViewController.h"

@interface UIViewKeyAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *tempView;
@property (weak, nonatomic) IBOutlet UIView *tempView1;
@property (nonatomic , strong) CALayer *layer;
@end

@implementation UIViewKeyAnimationViewController

- (void)loadView{
    self.view = [[NSBundle mainBundle] loadNibNamed:@"UIViewKeyAnimationViewController" owner:self options:nil].firstObject;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.bottomView = self.tempView1;
}

- (IBAction)keyAnimation:(UIButton *)sender {

    self.tempView.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:6.0 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        /**
         *  relativeDuration  动画在什么时候开始
         *  relativeStartTime 动画所持续的时间
         */
        [UIView addKeyframeWithRelativeStartTime:0// 相对于6秒所开始的时间（第0秒开始动画）
                                relativeDuration:1/3.0// 相对于6秒动画的持续时间（动画持续2秒）
                                      animations:^{
            self.tempView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0// 相对于6秒所开始的时间（第2秒开始动画）
                                relativeDuration:1/3.0// 相对于6秒动画的持续时间（动画持续2秒）
                                      animations:^{
            self.tempView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0// 相对于6秒所开始的时间（第4秒开始动画）
                                relativeDuration:1/3.0// 相对于6秒动画的持续时间（动画持续2秒）
                                      animations:^{
            self.tempView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    } completion:^(BOOL finished) {
        NSLog(@"Over==");
    }];
}

- (IBAction)springAnimation:(UIButton *)sender {
    [UIView animateWithDuration:4.0 //动画时长
                          delay:0.0 //动画延迟
         usingSpringWithDamping:0.2 //类似弹簧震动的效果 取值0~1
          initialSpringVelocity:2.0 //初始速度
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGPoint point = self.tempView.center;
                         point.x += 50;
                         [self.tempView setCenter:point];
          } completion:^(BOOL finished) {
              NSLog(@"over");
          }];
}
- (IBAction)transactionAnimation:(UIButton *)sender {
    
    self.layer = [CALayer layer];
    self.layer.bounds = CGRectMake(100, 100, 100, 100);
    self.layer.backgroundColor = [UIColor redColor].CGColor;
    self.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"xuehua3.jpg"].CGImage);
    [self.tempView.layer addSublayer:_layer];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CATransaction begin];
        [CATransaction setValue:@(2.0) forKey:kCATransactionAnimationDuration];
        self.layer.position = CGPointMake(200, 200);
        self.layer.zPosition = 50.0;
        self.layer.opacity = 0.5;
        [CATransaction commit];
    });
}
/**
 UIView类动画，可以一次性执行多个动画
 
 在UIView执行动画的相关函数中，有UIViewAnimationOptions这个参数可以对动画的执行效果进行设置，这个枚举非常多，可分为三部分，如下：
 enum {
 //这部分是基础属性的设置
 UIViewAnimationOptionLayoutSubviews            = 1 <<  0,//设置子视图随父视图展示动画
 UIViewAnimationOptionAllowUserInteraction      = 1 <<  1,//允许在动画执行时用户与其进行交互
 UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2,//允许在动画执行时执行新的动画
 UIViewAnimationOptionRepeat                    = 1 <<  3,//设置动画循环执行
 UIViewAnimationOptionAutoreverse               = 1 <<  4,//设置动画反向执行，必须和重复执行一起使用
 UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5,//强制动画使用内层动画的时间值
 UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6,//强制动画使用内层动画曲线值
 UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7,//设置动画视图实时刷新
 UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8,//设置视图切换时隐藏，而不是移除
 UIViewAnimationOptionOverrideInheritedOptions  = 1 <<  9,//
 //这部分属性设置动画播放的线性效果
 UIViewAnimationOptionCurveEaseInOut            = 0 << 16,//淡入淡出 首末减速
 UIViewAnimationOptionCurveEaseIn               = 1 << 16,//淡入 初始减速
 UIViewAnimationOptionCurveEaseOut              = 2 << 16,//淡出 末尾减速
 UIViewAnimationOptionCurveLinear               = 3 << 16,//线性 匀速执行
 //这部分设置UIView切换效果
 UIViewAnimationOptionTransitionNone            = 0 << 20,
 UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,//从左边切入
 UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,//从右边切入
 UIViewAnimationOptionTransitionCurlUp          = 3 << 20,//从上面立体进入
 UIViewAnimationOptionTransitionCurlDown        = 4 << 20,//从下面立体进入
 UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,//溶解效果
 UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,//从上面切入
 UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,//从下面切入
 };
 
 提示：
 1，属性可以使用|进行多项合并。
 2，这类的动画可以进行嵌套，其中有一点需要注意，内层动画的执行时间和曲线模式会默认继承外层动的，若要强制使用新的参数，使用如下的两个参数：
 UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5,//强制动画使用内层动画的时间值
 UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6,//强制动画使用内层动画曲线值
 */
- (IBAction)viewAnimation:(UIButton *)sender {
    CGContextRef context = UIGraphicsGetCurrentContext();//指定上下文
    //动画1
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:3.0];//持续时间
    [UIView setAnimationRepeatCount:0];//设置重复次数
    [UIView setAnimationRepeatAutoreverses:YES];//是不是执行逆向动画
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.tempView cache:YES];
    CGPoint point = self.tempView.center;
    point.y += 150;
    self.tempView.center = point;
    [UIView commitAnimations];//提交动画开始执行
    
    //动画2
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationRepeatCount:0];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationDuration:3.0];
    self.tempView.transform = CGAffineTransformMakeRotation(M_PI);
    [UIView commitAnimations];
}

//UIView的转场动画
- (IBAction)transition:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [UIView transitionFromView:self.tempView toView:self.tempView1 duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
            [self.bottomView addSubview:_tempView];
        }];
    }else{
        [UIView transitionFromView:self.tempView1 toView:self.tempView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            [self.bottomView addSubview:_tempView1];
        }];
    }
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

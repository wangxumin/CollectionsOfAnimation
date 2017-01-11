//
//  Transform3DViewController.m
//  CollectionsOfAnimation
//
//  Created by 王续敏 on 17/1/10.
//  Copyright © 2017年 wangxumin. All rights reserved.
//

#import "Transform3DViewController.h"

@interface Transform3DViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;
@property (nonatomic , assign) CGFloat tempAngel;
@end

@implementation Transform3DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tempAngel = - M_PI_4;
    CATransform3D transform = CATransform3DIdentity;
    
    CATransform3D transform1 = CATransform3DTranslate(transform, 0, 0, 70);
    self.view1.layer.transform = transform1;
    
    transform1 = CATransform3DTranslate(transform, 70, 0, 0);
    transform1 = CATransform3DRotate(transform1, M_PI_2, 0, 1, 0);
    self.view2.layer.transform = transform1;
    
    transform1 = CATransform3DTranslate(transform, 0, -70, 0);
    transform1 = CATransform3DRotate(transform1, M_PI_2 , 1 , 0 , 0);
    self.view3.layer.transform = transform1;
    
    transform1 = CATransform3DTranslate(transform, 0, 70, 0);
    transform1 = CATransform3DRotate(transform1, -M_PI_2 , -1 , 0 , 0);
    self.view4.layer.transform = transform1;
    
    transform1 = CATransform3DTranslate(transform, -70, 0, 0);
    transform1 = CATransform3DRotate(transform1, -M_PI_2 , 0 , 1 , 0);
    self.view5.layer.transform = transform1;
    
    transform1 = CATransform3DTranslate(transform, 0, 0, -70);
    transform1 = CATransform3DRotate(transform1, M_PI , 0 , 1 , 0);
    self.view6.layer.transform = transform1;
    
    transform = CATransform3DRotate(transform, self.tempAngel, 0, 1, 0);
    transform = CATransform3DRotate(transform, self.tempAngel, 1, 0, 0);
    self.containerView.layer.sublayerTransform = transform;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerAction:)];
    [self.containerView addGestureRecognizer:pan];
}
- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)sender{
    CGPoint point = [sender translationInView:self.containerView];
    CGFloat angel1 = self.tempAngel + (point.x / 70);
    CGFloat angel2 = self.tempAngel - (point.y / 70.0);
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/700;
    transform = CATransform3DRotate(transform, angel1, 0, 1, 0);
    transform = CATransform3DRotate(transform, angel2, 1, 0, 0);
    self.containerView.layer.sublayerTransform = transform;
    NSLog(@"%f==%f",point.x,point.y);
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

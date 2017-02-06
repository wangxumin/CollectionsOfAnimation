//
//  ViewController.m
//  CollectionsOfAnimation
//
//  Created by 王续敏 on 17/1/10.
//  Copyright © 2017年 wangxumin. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong) NSArray *dataSource;
@property (nonatomic , strong) UIImageView *imageView;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataSource = @[@"Transform3D",@"CAEmitterLayer",@"UIViewKeyAnimation",@"CABasicAnimation",@"CATransition"];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.image = [UIImage imageNamed:@"xuehua3.jpg"];
    [delegate.window addSubview:_imageView];
    [delegate.window bringSubviewToFront:_imageView];
    
    //制作启动图放大并慢慢消失的效果
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basic.toValue = @3.0;
    basic.duration = 1.0;
    basic.fillMode = kCAFillModeForwards;
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    basic.removedOnCompletion = NO;
    basic.delegate = self;
    [self.imageView.layer addAnimation:basic forKey:@"scale"];
    
    CABasicAnimation *alphBasic = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphBasic.duration = 1.0;
    alphBasic.toValue = @0;
    alphBasic.fillMode = kCAFillModeForwards;
    alphBasic.removedOnCompletion = NO;
    alphBasic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    alphBasic.delegate = self;
    [self.imageView.layer addAnimation:alphBasic forKey:@"alpha"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.imageView removeFromSuperview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
       cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *object = [NSString stringWithFormat:@"%@ViewController",self.dataSource[indexPath.row]];
    Class class = NSClassFromString(object);
    UIViewController *vc = (UIViewController *)[class new];
    vc.title = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

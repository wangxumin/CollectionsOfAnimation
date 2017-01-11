//
//  CAEmitterLayerViewController.m
//  CollectionsOfAnimation
//
//  Created by 王续敏 on 17/1/10.
//  Copyright © 2017年 wangxumin. All rights reserved.
//

#import "CAEmitterLayerViewController.h"

@interface CAEmitterLayerViewController ()
@property (nonatomic , strong) CAEmitterLayer *snowLayer;
@end

@implementation CAEmitterLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置发射器
    self.snowLayer = [[CAEmitterLayer alloc] init];
    self.snowLayer.frame = CGRectMake(0, -70, self.view.bounds.size.width, 50);
    self.snowLayer.emitterShape = kCAEmitterLayerCircle;
    self.snowLayer.renderMode = kCAEmitterLayerAdditive;//粒子的混合模式
    NSMutableArray *array = [NSMutableArray array];
    NSArray *images = @[@"xuhua2.png",@"xuehua3.jpg"];
    for (int i = 0; i < images.count; i++) {
        //发射单元
        CAEmitterCell *cell = [CAEmitterCell emitterCell];
        cell.contents = (__bridge id _Nullable)([self getThumbImageWithImage:[UIImage imageNamed:images[i]] andSize:CGSizeMake(30.0, 30.0) Scale:NO].CGImage);//粒子展示的图片
        cell.name = @"snow";
        cell.birthRate = 120;  //每秒产生的粒子数
        cell.lifetime = 3;    //存活时间
        cell.lifetimeRange = 3.0;//存活时间变化范围
        
        cell.yAcceleration = 70.0;  //给Y方向一个加速度
        cell.xAcceleration = 20.0; //x方向一个加速度
        cell.velocity = 20.0; //初始速度
        cell.velocityRange = 200.0;   //速度变化范围
        cell.emissionLongitude = (-M_PI); //向左
        cell.emissionRange = (M_PI_2); //方向范围
        //cell.color = UIColor(red: 0.9, green: 1.0, blue: 1.0,
        //   alpha: 1.0).CGColor //指定颜色
//            cell.redRange = 0.3;
        //    cell.greenRange = 0.3;
        //    cell.blueRange = 0.3 ; //三个随机颜色
        
        cell.scale = 0.8;//缩放
        cell.scaleRange = 0.8;  //0 - 1.6
        cell.scaleSpeed = -0.15;  //逐渐变小
        cell.alphaRange = 0.75;   //随机透明度
        cell.alphaSpeed = -0.15;  //逐渐消失
        [array addObject:cell];
    }
    self.snowLayer.emitterCells = array;  //这里可以设置多种粒子
    [self.view.layer addSublayer:_snowLayer];
}

/**
 *  得到图片的缩略图
 *
 *  @param image 原图
 *  @param Size  想得到的缩略图尺寸
 *  @param Scale Scale为YES：原图会根据Size进行拉伸-会变形，Scale为NO：原图会根据Size进行填充-不会变形
 *
 *  @return 新生成的图片
 */
-(UIImage *)getThumbImageWithImage:(UIImage *)image andSize:(CGSize)Size Scale:(BOOL)Scale{
    
    UIGraphicsBeginImageContextWithOptions(Size, NO, 0.0);
    CGRect rect = CGRectMake(0,
                             0,
                             Size.width,
                             Size.height);
    if (!Scale) {
        CGFloat bili_imageWH = image.size.width/image.size.height;
        CGFloat bili_SizeWH  = Size.width/Size.height;
        if (bili_imageWH > bili_SizeWH) {
            CGFloat bili_SizeH_imageH = Size.height/image.size.height;
            CGFloat height = image.size.height*bili_SizeH_imageH;
            CGFloat width = height * bili_imageWH;
            CGFloat x = -(width - Size.width)/2;
            CGFloat y = 0;
            rect = CGRectMake(x,
                              y,
                              width,
                              height);
        }else{
            CGFloat bili_SizeW_imageW = Size.width/image.size.width;
            CGFloat width = image.size.width * bili_SizeW_imageW;
            CGFloat height = width / bili_imageWH;
            CGFloat x = 0;
            CGFloat y = -(height - Size.height)/2;
            rect = CGRectMake(x,
                              y,
                              width,
                              height);
        }
    }
    [[UIColor clearColor] set];
    UIRectFill(rect);
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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

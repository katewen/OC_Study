//
//  LayerTestViewController.m
//  OC_Study
//
//  Created by 技术 on 2021/3/12.
//

#import "LayerTestViewController.h"

@interface LayerTestViewController ()

@end

@implementation LayerTestViewController

- (void)founcation {
    // 路径类型
//    CGPathRef
    // 绘制bitmap
//    CGImageRef
    // 绘制 layer 可复用 支持离屏渲染
//    CGLayerRef
    // 重复绘制
//    CGPatternRef
    // 绘制渐变
//    CGShadingRef
    // 绘制 渐变
//    CGGradientRef
    // 定义回调函数
//    CGFunctionRef
    // 处理颜色
//    CGColorRef
    // 处理字体
//    CGFontRef
    
    //bitmap 位图 每个像素点 1-32bit组成 每个像素点包括颜色组件和alpha组件（RGBA）
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"2D绘图，CALayer";
    
//    TestTenthView *testView = [[TestTenthView alloc]init];
//    [self.view addSubview:testView];
//    testView.frame = CGRectMake(100, 100, 100, 100);
//    [self drwaMyLayer];
    [self drawCircleImage];
    // Do any additional setup after loading the view.
}


- (void)drwaMyLayer {
    CGSize size = UIScreen.mainScreen.bounds.size;
    CALayer *layer = [[CALayer alloc]init];
    layer.backgroundColor = UIColor.redColor.CGColor;
    // 设置中心点
    layer.position = CGPointMake(size.width/2, size.height/2);
    // 设置
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.cornerRadius = 50;
    
    layer.shadowColor = UIColor.lightGrayColor.CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = .9;
    
    [self.view.layer addSublayer:layer];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CALayer *layer = self.view.layer.sublayers[1];
    CGFloat width = layer.bounds.size.width;
    
    if (width==100) {
        width = 100*2;
    }else{
        width = 100;
    }
    layer.bounds = CGRectMake(0, 0, width, width);
    layer.position = [touch locationInView:self.view];
    layer.cornerRadius = width/2;
    
}

// 绘制圆形图片

- (void)drawCircleImage {
    
    CGSize size = UIScreen.mainScreen.bounds.size;
    
    //阴影图层
    CALayer *shadowLayer = [[CALayer alloc]init];
    shadowLayer.bounds = CGRectMake(0, 0, 200, 200);
    shadowLayer.position = CGPointMake(size.width/2, size.height/2);
    shadowLayer.cornerRadius = 100;
    shadowLayer.borderColor = UIColor.whiteColor.CGColor;
    shadowLayer.borderWidth = 2;
    shadowLayer.shadowColor = [UIColor greenColor].CGColor;
    shadowLayer.shadowOffset = CGSizeMake(2, 1);
    shadowLayer.shadowOpacity = 1;
//    shadowLayer.shadowRadius  如果阴影层设置阴影圆角 会无法显示
    [self.view.layer addSublayer:shadowLayer];
    
    CALayer *layer = [[CALayer alloc]init];
    layer.backgroundColor = UIColor.whiteColor.CGColor;
    layer.position = CGPointMake(size.width/2, size.height/2);
    layer.bounds = CGRectMake(0, 0, 200, 200);
    layer.cornerRadius = 100;
    layer.masksToBounds = YES;
    
    layer.borderColor = UIColor.whiteColor.CGColor;
    layer.borderWidth = 1;
    
    layer.delegate = self;
    
    [self.view.layer addSublayer:layer];
    // 不调用 delegate方法不执行
    [layer setNeedsDisplay];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
    CGContextSaveGState(ctx);
    // 上下文形变  解决图片倒立 的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -200);
    
    UIImage *image = [UIImage imageNamed:@"timg.jpeg"];
    CGContextDrawImage(ctx, CGRectMake(0, 0, 200, 200), image.CGImage);
    
    CGContextRestoreGState(ctx);
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    
}

@end

@interface CALayer (myLayer)

@end

@implementation CALayer (myLayer)


@end

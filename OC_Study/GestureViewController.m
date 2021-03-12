//
//  GestureViewController.m
//  OC_Study
//
//  Created by 技术 on 2021/3/11.
//

#import "GestureViewController.h"

@interface GestureViewController ()<UIGestureRecognizerDelegate>

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手势";
    self.view.backgroundColor = UIColor.grayColor;
    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timg.jpeg"]];
    [imageView setUserInteractionEnabled:YES];
    [self.view addSubview:imageView];
    
    imageView.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width/2-80/2, UIScreen.mainScreen.bounds.size.height/2-40, 80, 80);
    
//    [self testTap];
//    [self testSwip];
    [self testLongPress];
//    [self testPan];
    [self testRotation];
    [self testPinch];
    // Do any additional setup after loading the view.
}

//点击手势
- (void)testTap {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showAlertVcWithMessage:)];
    //手指数
    tap.numberOfTouchesRequired = 2;
    //点击次数
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}
// 轻扫手势
- (void)testSwip {
    
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(showAlertVcWithMessage:)];
    swip.numberOfTouchesRequired = 1;
    swip.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swip];
    
}
// 长按手势
- (void)testLongPress {
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(showAlertVcWithMessage:)];
    longPress.minimumPressDuration = 2.0;
    [self.view addGestureRecognizer:longPress];
    
}

//拖拽手势
- (void)testPan {
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewControllPan:)];
    pan.delegate = self;
    [imageView addGestureRecognizer:pan];
    
}

// 旋转手势
- (void)testRotation {
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationAction:)];
    rotation.delegate = self;
    [imageView addGestureRecognizer:rotation];
    
}

// 捏合手势
- (void)testPinch {
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchAction:)];
    pinch.delegate = self;
    [imageView addGestureRecognizer:pinch];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)showAlertVcWithMessage:(NSString *)message {
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"手势测试" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"yes" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addAction:sure];
    [self presentViewController:alertVc animated:YES completion:nil];
    
}

//拖拽操作
- (void)imageViewControllPan:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state==UIGestureRecognizerStateBegan) {
        
    }else if (recognizer.state==UIGestureRecognizerStateChanged){
        CGPoint tranP = [recognizer translationInView:imageView];
        imageView.transform = CGAffineTransformTranslate(imageView.transform, tranP.x, tranP.y);
        [recognizer setTranslation:CGPointZero inView:imageView];
        
    }else{
        
        
        
    }
    
}

- (void)rotationAction:(UIRotationGestureRecognizer *)rotation {
    
    imageView.transform = CGAffineTransformRotate(imageView.transform, rotation.rotation);
    [rotation setRotation:0];
    
}

- (void)pinchAction:(UIPinchGestureRecognizer *)pinch {
    
    imageView.transform = CGAffineTransformScale(imageView.transform, pinch.scale, pinch.scale);
    [pinch setScale:1];
    
}


@end

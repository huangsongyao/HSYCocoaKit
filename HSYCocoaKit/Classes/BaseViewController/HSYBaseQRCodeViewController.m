//
//  HSYBaseQRCodeViewController.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/22.
//

#import "HSYBaseQRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "NSObject+UIKit.h"
#import "ReactiveCocoa.h"
#import "UIImage+Canvas.h"
#import "PublicMacroFile.h"
#import "UIView+Frame.h"
#import "UIViewController+QRCode.h"
#import "UIViewController+Device.h"
#import "UIViewController+Alert.h"
#import "NSBundle+PrivateFileResource.h"

static NSString *const kHSYCocoaKitScaningAnimatedKey = @"HSYCocoaKitScaningAnimatedKey";

@interface HSYBaseQRCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *hsy_session;                    //输入输出的中间桥梁
@property (nonatomic, strong) AVCaptureDevice *hsy_device;                      //摄像头设备
@property (nonatomic, strong) AVCaptureDeviceInput *hsy_input;                  //输入流
@property (nonatomic, strong) AVCaptureMetadataOutput *hsy_output;              //输出流
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *hsy_previewLayer;     //图象渲染层

@property (nonatomic, strong) UIImageView *scanLayer;                           //扫描线
@property (nonatomic, assign) BOOL hsy_isCreateQRCodeCamera;                    //是否创建了二维码相机
@property (nonatomic, assign) CGRect hsy_boxCGRect;                             //扫描有效区域

@end

@implementation HSYBaseQRCodeViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.hsy_box = 60.0f;
        self.hsy_boy = 140.0f;
        self.hsy_boxColor = RGBA(51, 51, 51, 0.5f);
        self.hsy_isCreateQRCodeCamera = NO;
        self.hsy_boxBackgroundImageName = @"class_scanning_bg";
        self.hsy_boxScaningLineImageName = @"scanning_line";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BLACK_COLOR;
    //定义好扫描区域
    CGFloat size = self.view.width - (self.hsy_box * 2);
    self.hsy_boxCGRect = CGRectMake(self.hsy_box, self.hsy_boy, size, size);
    //初始化UI
    [self hsy_addQRCodeUI];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.hsy_isCreateQRCodeCamera) {
        if ([UIViewController canOpenCamera]) {
            [self hsy_addQRCodeCameraSession];
            self.hsy_isCreateQRCodeCamera = YES;
        } else {
            [UIViewController hsy_hudWithMessage:HSYLOCALIZED(@"您的设备不支持或者无权打开相机！")];
        }
    }
}

- (void)dealloc
{
    [self hsy_stopRunning];
    [self hsy_stopAnimated];
}

#pragma mark - Start QRCode UI

- (void)hsy_addQRCodeUI
{
    //中空的背景图
    [self.view addSubview:self.hsy_createBackgroundImage];
    //有效区域的扫描框
    [self.view addSubview:self.hsy_createBoxView];
    //有效区域的扫描线
    self.scanLayer = self.hsy_createScaningLine;
    [self.view addSubview:self.scanLayer];
    //开始扫描动画
    [self hsy_startAnimated];
}

#pragma mark - Create QRCode Camera

- (void)hsy_addQRCodeCameraSession
{
    //获取摄像设备
    if (!self.hsy_device) {
        self.hsy_device = [self hsy_createDevice];
    }
    //创建输入流
    if (!self.hsy_input) {
        NSError *error = nil;
        self.hsy_input = [self hsy_createDeviceInputWithDevice:self.hsy_device error:error];
    }
    //创建输出流,并给定扫描范围
    if (!self.hsy_output) {
        CGRect rectOfInterest = [self qrCodeScaningZone:self.hsy_boxCGRect];
        self.hsy_output = [self hsy_createMetadataOutputWithRectOfInterest:rectOfInterest];
    }
    //初始化链接对象
    if (!self.hsy_session) {
        self.hsy_session = [self hsy_createAVCaptureSessionWithInput:self.hsy_input output:self.hsy_output];
    }
    if (self.hsy_session && self.hsy_output) {
        //完成输入流和输出流的对接后,开始设置输出流的支持类型，扫码支持的编码格式(如下设置条形码和二维码兼容)
        self.hsy_output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    }
    //图象渲染层
    if (!self.hsy_previewLayer) {
        self.hsy_previewLayer = [self hsy_createVideoPreviewLayerWithSession:self.hsy_session
                                                                 showInLayer:self.view.layer];
    }
    //开始捕获
    [self hsy_startRunning];
}

#pragma mark - Animation

- (void)hsy_startAnimated
{
    [self hsy_stopAnimated];
    [self qrCodeScaningAnimation:CGRectGetHeight(self.hsy_boxCGRect)
                         onLayer:self.scanLayer.layer
                          forKey:kHSYCocoaKitScaningAnimatedKey];
}

- (void)hsy_stopAnimated
{
    [self.scanLayer.layer removeAnimationForKey:kHSYCocoaKitScaningAnimatedKey];
}

#pragma mark - Running

- (void)hsy_startRunning
{
    if (!self.hsy_session) {
        return;
    }
    [self.hsy_session startRunning];
}

- (void)hsy_stopRunning
{
    if (!self.hsy_session) {
        return;
    }
    [self.hsy_session stopRunning];
}

#pragma mark - Create QRCode Video Device Environmental

- (AVCaptureDevice *)hsy_createDevice
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    return device;
}

- (AVCaptureDeviceInput *)hsy_createDeviceInputWithDevice:(AVCaptureDevice *)device
                                                    error:(NSError *)error
{
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        NSLog(@"QRCode Camera Error!------AVCaptureDeviceInput Error:%@", error);
    }
    return input;
}

- (AVCaptureMetadataOutput *)hsy_createMetadataOutputWithRectOfInterest:(CGRect)rectOfInterest
{
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    output.rectOfInterest = rectOfInterest;                                     //扫描范围
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];   //设置代理 在主线程里刷新
    return output;
}

- (AVCaptureVideoPreviewLayer *)hsy_createVideoPreviewLayerWithSession:(AVCaptureSession *)session
                                                           showInLayer:(CALayer *)showInLayer
{
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    previewLayer.frame = self.view.layer.bounds;
    [showInLayer insertSublayer:previewLayer atIndex:0];
    
    return previewLayer;
}

- (AVCaptureSession *)hsy_createAVCaptureSessionWithInput:(AVCaptureDeviceInput *)input
                                                   output:(AVCaptureMetadataOutput *)output
{
    AVCaptureSession *session = [[AVCaptureSession alloc] init];    //初始化链接对象
    [session setSessionPreset:AVCaptureSessionPresetHigh];          //高质量采集率
    
    [session addInput:input];
    [session addOutput:output];
    
    return session;
}

#pragma mark - Background UI

- (UIImageView *)hsy_createBackgroundImage
{
    UIImage *image = [UIImage imageWithQRCode:self.view.bounds
                                     cropRect:self.hsy_boxCGRect
                              backgroundColor:self.hsy_boxColor];
    UIImageView *backgroundImage = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : image, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : image}];
    backgroundImage.frame = self.view.bounds;
    return backgroundImage;
}

- (UIImageView *)hsy_createScaningLine
{
    UIImage *image = [UIImage imageNamed:self.hsy_boxScaningLineImageName];
    if (!image) {
        image = [NSBundle imageForBundle:self.hsy_boxScaningLineImageName];
    }
    UIImageView *line = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : image, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : image}];
    line.frame = (CGRect){self.hsy_boxCGRect.origin, CGRectGetWidth(self.hsy_boxCGRect), image.size.height};
    return line;
}

- (UIView *)hsy_createBoxView
{
    UIView *boxView = [[UIView alloc] initWithFrame:self.hsy_boxCGRect];
    UIImage *image = [UIImage imageNamed:self.hsy_boxBackgroundImageName];
    if (!image) {
        image = [NSBundle imageForBundle:self.hsy_boxBackgroundImageName];
    }
    UIImageView *boxBackgroundImageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : image, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : image}];
    boxBackgroundImageView.frame = boxView.bounds;
    [boxView addSubview:boxBackgroundImageView];
    
    return boxView;
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        [self hsy_stopAnimated];
        [self hsy_stopRunning];
        @weakify(self);
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects firstObject];
        if (self.qrDelgate && [self.qrDelgate respondsToSelector:@selector(hsy_qrCodeDidOutputMetadata:)]) {
            [[[self.qrDelgate hsy_qrCodeDidOutputMetadata:metadataObject.stringValue] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSNumber *restart) {
                @strongify(self);
                if (restart.boolValue) {
                    [self hsy_startRunning];
                    [self hsy_startAnimated];
                }
            }];
        }
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

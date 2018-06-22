//
//  HSYBaseQRCodeViewController.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/22.
//

#import <UIKit/UIKit.h>

@interface HSYBaseQRCodeViewController : UIViewController

@property (nonatomic, assign) CGFloat hsy_box;                      //扫描区域的x坐标，默认为60.0f
@property (nonatomic, assign) CGFloat hsy_boy;                      //扫描区域的y坐标，默认为140.0f
@property (nonatomic, strong) UIColor *hsy_boxColor;                //背景图的颜色，默认为RGBA(51.0f, 51.0f, 51.0f, 0.5f)
@property (nonatomic, copy) NSString *hsy_boxBackgroundImageName;   //有效区域的框的图片名称，有默认图片
@property (nonatomic, copy) NSString *hsy_boxScaningLineImageName;  //有效区域的扫描线图片的名称，有默认图片

/**
 开始扫描
 */
- (void)hsy_startRunning;

/**
 停止扫描
 */
- (void)hsy_stopRunning;

/**
 停止动画
 */
- (void)hsy_stopAnimated;

@end

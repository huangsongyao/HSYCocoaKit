//
//  CIDetector+QRCode.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/10.
//

#import "CIDetector+QRCode.h"
#import "UIImage+Compression.h"
#import "UIImage+Canvas.h"

NSString *const kHSYCocoaKitCIFilterInputCorrectionLevelIsHigh        = @"H";
NSString *const kHSYCocoaKitCIFilterInputCorrectionLevelIsMiddle      = @"M";
NSString *const kHSYCocoaKitCIFilterInputCorrectionLevelIsLow         = @"L";

#define DEFAULT_DETECTOR_IMAGE_REAL_SIZE                CGSizeMake(280.0f, 280.0f)

@implementation CIDetector (QRCode)

#pragma mark - Detector QRCode

+ (NSString *)detectorQRCodeImage:(UIImage *)image
{
    CIContext *ciContent = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES), }];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:ciContent options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    
    UIImage *realImage = image;
    if (!CGSizeEqualToSize(realImage.size, DEFAULT_DETECTOR_IMAGE_REAL_SIZE)) {
        realImage = [realImage imageCompressionSize:DEFAULT_DETECTOR_IMAGE_REAL_SIZE];
    }
    
    CIImage *ciImage = [CIImage imageWithCGImage:realImage.CGImage];
    NSArray<CIFeature *> *features = [detector featuresInImage:ciImage];
    CIQRCodeFeature *feature = (CIQRCodeFeature *)features.firstObject;
    NSString *result = feature.messageString;
    
    NSLog(@"\n detector QRCode is : %@", result);
    return result;
}

#pragma mark - Create QRCode Image

+ (UIImage *)filterHighQrCodeImage:(NSString *)qrString withImageSize:(CGFloat)size
{
    return [self.class filterQrCodeImage:qrString qrCorrectionLevel:kHSYCocoaKitCIFilterInputCorrectionLevelIsHigh withImageSize:size];
}

+ (UIImage *)filterMiddleQrCodeImage:(NSString *)qrString withImageSize:(CGFloat)size
{
    return [self.class filterQrCodeImage:qrString qrCorrectionLevel:kHSYCocoaKitCIFilterInputCorrectionLevelIsMiddle withImageSize:size];
}

+ (UIImage *)filterLowQrCodeImage:(NSString *)qrString withImageSize:(CGFloat)size
{
    return [self.class filterQrCodeImage:qrString qrCorrectionLevel:kHSYCocoaKitCIFilterInputCorrectionLevelIsLow withImageSize:size];
}

+ (UIImage *)filterQrCodeImage:(NSString *)qrString qrCorrectionLevel:(NSString *)level withImageSize:(CGFloat)size
{
    if (qrString.length == 0) {
        return nil;
    }
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:level forKey:@"inputCorrectionLevel"];
    
    CIImage *ciImage = [filter outputImage];
    UIImage *qrCodeImage = [UIImage imageWithQrCodeSize:size withCIImage:ciImage];
    
    return qrCodeImage;
}

#pragma mark - Create Logo QRCode Image

+ (UIImage *)filterLogoQrCodeImage:(NSString *)qrString qrCorrectionLevel:(NSString *)level withImageSize:(CGFloat)size logo:(NSString *)logo logoSize:(CGFloat)logoSize
{
    UIImage *qrCodeImage = [CIDetector filterQrCodeImage:qrString qrCorrectionLevel:level withImageSize:size];
    UIImage *logoImage = [UIImage imageNamed:logo];
    if (!logoImage) {
        return qrCodeImage;
    }
    UIGraphicsBeginImageContext(qrCodeImage.size);
    [qrCodeImage drawInRect:(CGRect){CGPointZero, qrCodeImage.size}];
    CGRect logoRect = (CGRect){(qrCodeImage.size.width - logoSize)/2.0f, (qrCodeImage.size.height - logoSize)/2.0f, CGSizeMake(logoSize, logoSize)};
    [logoImage drawInRect:logoRect];
    
    UIImage *logoQrCodeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return logoQrCodeImage;
}

+ (UIImage *)filterHighLogoQrCodeImage:(NSString *)qrString withImageSize:(CGFloat)size logo:(NSString *)logo logoSize:(CGFloat)logoSize
{
    return [self.class filterLogoQrCodeImage:qrString qrCorrectionLevel:kHSYCocoaKitCIFilterInputCorrectionLevelIsHigh withImageSize:size logo:logo logoSize:logoSize];
}

+ (UIImage *)filterMiddleLogoQrCodeImage:(NSString *)qrString withImageSize:(CGFloat)size logo:(NSString *)logo logoSize:(CGFloat)logoSize
{
    return [self.class filterLogoQrCodeImage:qrString qrCorrectionLevel:kHSYCocoaKitCIFilterInputCorrectionLevelIsMiddle withImageSize:size logo:logo logoSize:logoSize];
}

+ (UIImage *)filterLowLogoQrCodeImage:(NSString *)qrString withImageSize:(CGFloat)size logo:(NSString *)logo logoSize:(CGFloat)logoSize
{
    return [self.class filterLogoQrCodeImage:qrString qrCorrectionLevel:kHSYCocoaKitCIFilterInputCorrectionLevelIsLow withImageSize:size logo:logo logoSize:logoSize];
}


@end

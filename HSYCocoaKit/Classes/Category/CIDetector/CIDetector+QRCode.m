//
//  CIDetector+QRCode.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/10.
//

#import "CIDetector+QRCode.h"
#import "UIImage+Compression.h"

#define DEFAULT_DETECTOR_IMAGE_REAL_SIZE                CGSizeMake(280.0f, 280.0f)

@implementation CIDetector (QRCode)

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

@end

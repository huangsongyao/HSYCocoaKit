//
//  CIDetector+QRCode.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/10.
//

#import "CIDetector+QRCode.h"

@implementation CIDetector (QRCode)

+ (NSString *)detectorQRCodeImage:(UIImage *)image
{
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    NSArray<CIFeature *> *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    CIQRCodeFeature *feature = (CIQRCodeFeature *)features.firstObject;
    NSString *result = feature.messageString;
    
    return result;
}

@end

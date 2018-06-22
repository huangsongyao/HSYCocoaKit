//
//  UIViewController+Device.h
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

typedef NS_ENUM(NSUInteger, kHSYCocoaKitDeviceType) {
    
    kHSYCocoaKitDeviceTypeCamera,
    kHSYCocoaKitDeviceTypePhoto,
    kHSYCocoaKitDeviceTypeVideo,
    
};

@interface UIViewController (Device) <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/**
 是否能打开摄像机

 @return BOOL值，YES表示可以
 */
+ (BOOL)canOpenCamera;

/**
 打开系统相册，默认为选中一张图片后，会进入系统自定的图片编辑模式

 @return RACTuple，其中，RACTuple对象自带的1-5个信息体依次顺序分别为：1、UIImagePickerControllerCropRect；2、UIImagePickerControllerEditedImage；3、UIImagePickerControllerMediaType；4、UIImagePickerControllerOriginalImage；5、UIImagePickerControllerReferenceURL；
 */
- (RACSignal *)hsy_rac_openEditingSystemPhoto;

/**
 打开系统相册，默认为选中一张图片后，不进入系统的编辑模式

 @return RACTuple，其中，RACTuple对象自带的1-5个信息体依次顺序分别为：1、UIImagePickerControllerCropRect；2、UIImagePickerControllerEditedImage；3、UIImagePickerControllerMediaType；4、UIImagePickerControllerOriginalImage；5、UIImagePickerControllerReferenceURL；
 */
- (RACSignal *)hsy_rac_openSystemPhoto;

/**
 打开系统摄像头，默认为拍照后，进入系统自带的图片编辑模式

 @return RACTuple，其中，RACTuple对象自带的1-5个信息体依次顺序分别为：1、UIImagePickerControllerEditedImage；2、UIImagePickerControllerMediaMetadata；3、UIImagePickerControllerCropRect；4、UIImagePickerControllerMediaType；5、UIImagePickerControllerOriginalImage；
 */
- (RACSignal *)hsy_rac_openEditingSystemCamera;

/**
 打开系统摄像头，默认为拍照后，不进入系统自带的图片编辑模式
 
 @return RACTuple，其中，RACTuple对象自带的1-5个信息体依次顺序分别为：1、UIImagePickerControllerEditedImage；2、UIImagePickerControllerMediaMetadata；3、UIImagePickerControllerCropRect；4、UIImagePickerControllerMediaType；5、UIImagePickerControllerOriginalImage；
 */
- (RACSignal *)hsy_rac_openSystemCamera;

/**
 打开系统视频库，默认选中后会进入视频编辑模式

 @return RACTuple，其中，RACTuple对象自带的1-5个信息体依次顺序分别为：1、UIImagePickerControllerMediaURL；2、UIImagePickerControllerMediaType；3、UIImagePickerControllerReferenceURL；
 */
- (RACSignal *)hsy_rac_openEditingSystemVideos;

/**
 打开系统视频库，默认选中后不进入视频编辑模式
 
 @return RACTuple，其中，RACTuple对象自带的1-5个信息体依次顺序分别为：1、UIImagePickerControllerMediaURL；2、UIImagePickerControllerMediaType；3、UIImagePickerControllerReferenceURL；
 */
- (RACSignal *)hsy_rac_openSystemVideos;

@end

//
//  UIViewController+Device.m
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import "UIViewController+Device.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "RACDelegateProxy.h"
#import "HSYBaseViewController.h"

@implementation UIViewController (Device)

#pragma mark - Check On System Device

+ (BOOL)canOpenCamera
{
    return [self canDeviceForSourceType:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL)canDeviceForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    return [UIImagePickerController isSourceTypeAvailable:sourceType];
}

+ (BOOL)canOpenCameraDeviceForDeviceType:(kHSYCocoaKitDeviceType)deviceType
{
    NSDictionary *sourceTypes = @{
                                  @(kHSYCocoaKitDeviceTypePhoto)  : @(UIImagePickerControllerSourceTypePhotoLibrary),
                                  @(kHSYCocoaKitDeviceTypeVideo)  : @(UIImagePickerControllerSourceTypeSavedPhotosAlbum),
                                  @(kHSYCocoaKitDeviceTypeCamera) : @(UIImagePickerControllerSourceTypeCamera),
                                  };
    UIImagePickerControllerSourceType sourceType = (UIImagePickerControllerSourceType)[sourceTypes[@(deviceType)] integerValue];
    return [self.class canDeviceForSourceType:sourceType];
}

#pragma mark - UIImagePickerController

+ (UIImagePickerController *)createImagePickerControllerForDelegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate canAllowsEditing:(BOOL)allowsEditing withDeviceType:(kHSYCocoaKitDeviceType)deviceType
{
    if (![self.class canOpenCameraDeviceForDeviceType:deviceType]) {
        return nil;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = delegate;
    //适配iOS 11
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    imagePickerController.allowsEditing = allowsEditing;//打开图片编辑，设置为NO时不会跳转到系统定义下的编辑页面
    NSDictionary *sourceTypes = @{
                                 @(kHSYCocoaKitDeviceTypePhoto)  : @(UIImagePickerControllerSourceTypePhotoLibrary),
                                 @(kHSYCocoaKitDeviceTypeVideo)  : @(UIImagePickerControllerSourceTypeSavedPhotosAlbum),
                                 @(kHSYCocoaKitDeviceTypeCamera) : @(UIImagePickerControllerSourceTypeCamera),
                                 };
    NSDictionary *mediatypes = @{
                                  @(kHSYCocoaKitDeviceTypePhoto)  : @[(NSString *)kUTTypeImage],
                                  @(kHSYCocoaKitDeviceTypeVideo)  : @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeVideo],
                                  };
    imagePickerController.sourceType = (UIImagePickerControllerSourceType)[sourceTypes[@(deviceType)] integerValue];
    if (mediatypes[@(deviceType)]) {
        imagePickerController.mediaTypes = mediatypes[@(deviceType)];
    }
    return imagePickerController;
}

#pragma mark - RAC

- (RACSignal *)rac_openSystemResourcesForDeviceType:(kHSYCocoaKitDeviceType)type canAllowsEditing:(BOOL)can
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        __block UIImagePickerController *imagePickerController = [UIViewController createImagePickerControllerForDelegate:self canAllowsEditing:can withDeviceType:type];
        [[[imagePickerController rac_imageSelectedSignal] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
            [subscriber sendNext:x];
            [imagePickerController dismissViewControllerAnimated:YES completion:^{}];
        } completed:^{
            [subscriber sendCompleted];
            [imagePickerController dismissViewControllerAnimated:YES completion:^{}];
        }];
        [self presentViewController:imagePickerController animated:YES completion:^{
        }];
        return [RACDisposable disposableWithBlock:^{}];
    }];
}

- (RACSignal *)hsy_rac_openEditingSystemPhoto
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[self rac_openSystemResourcesForDeviceType:kHSYCocoaKitDeviceTypePhoto canAllowsEditing:YES] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDictionary *imageDictionary) {
            RACTuple *tuple = RACTuplePack(imageDictionary[UIImagePickerControllerCropRect], imageDictionary[UIImagePickerControllerEditedImage], imageDictionary[UIImagePickerControllerMediaType], imageDictionary[UIImagePickerControllerOriginalImage], imageDictionary[UIImagePickerControllerReferenceURL]);
            [subscriber sendNext:tuple];
        } completed:^{
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release method “- hsy_rac_openEditingSystemPhoto”");
        }];
    }];
}

- (RACSignal *)hsy_rac_openSystemPhoto
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[self rac_openSystemResourcesForDeviceType:kHSYCocoaKitDeviceTypePhoto canAllowsEditing:NO] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDictionary *imageDictionary) {
            RACTuple *tuple = RACTuplePack(imageDictionary[UIImagePickerControllerCropRect], imageDictionary[UIImagePickerControllerEditedImage], imageDictionary[UIImagePickerControllerMediaType], imageDictionary[UIImagePickerControllerOriginalImage], imageDictionary[UIImagePickerControllerReferenceURL]);
            [subscriber sendNext:tuple];
        } completed:^{
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release method “- hsy_rac_openSystemPhoto”");
        }];
    }];
}

- (RACSignal *)hsy_rac_openEditingSystemCamera
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[self rac_openSystemResourcesForDeviceType:kHSYCocoaKitDeviceTypeCamera canAllowsEditing:YES] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDictionary *imageDictionary) {
            RACTuple *tuple = RACTuplePack(imageDictionary[UIImagePickerControllerEditedImage], imageDictionary[UIImagePickerControllerMediaMetadata], imageDictionary[UIImagePickerControllerCropRect], imageDictionary[UIImagePickerControllerMediaType], imageDictionary[UIImagePickerControllerOriginalImage]);
            [subscriber sendNext:tuple];
        } completed:^{
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release method “- hsy_rac_openEditingSystemCamera”");
        }];
    }];
}

- (RACSignal *)hsy_rac_openSystemCamera
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[self rac_openSystemResourcesForDeviceType:kHSYCocoaKitDeviceTypeCamera canAllowsEditing:NO] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDictionary *imageDictionary) {
            RACTuple *tuple = RACTuplePack(imageDictionary[UIImagePickerControllerEditedImage], imageDictionary[UIImagePickerControllerMediaMetadata], imageDictionary[UIImagePickerControllerCropRect], imageDictionary[UIImagePickerControllerMediaType], imageDictionary[UIImagePickerControllerOriginalImage]);
            [subscriber sendNext:tuple];
        } completed:^{
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release method “- hsy_rac_openSystemCamera”");
        }];
    }];
}

- (RACSignal *)hsy_rac_openEditingSystemVideos
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[self rac_openSystemResourcesForDeviceType:kHSYCocoaKitDeviceTypeVideo canAllowsEditing:YES] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDictionary *imageDictionary) {
            RACTuple *tuple = RACTuplePack(imageDictionary[UIImagePickerControllerMediaURL], imageDictionary[UIImagePickerControllerMediaType], imageDictionary[UIImagePickerControllerReferenceURL]);
            [subscriber sendNext:tuple];
        } completed:^{
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release method “- hsy_rac_openSystemCamera”");
        }];
    }];
}

- (RACSignal *)hsy_rac_openSystemVideos
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[self rac_openSystemResourcesForDeviceType:kHSYCocoaKitDeviceTypeVideo canAllowsEditing:NO] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDictionary *imageDictionary) {
            RACTuple *tuple = RACTuplePack(imageDictionary[UIImagePickerControllerMediaURL], imageDictionary[UIImagePickerControllerMediaType], imageDictionary[UIImagePickerControllerReferenceURL]);
            [subscriber sendNext:tuple];
        } completed:^{
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release method “- hsy_rac_openSystemCamera”");
        }];
    }];
}

@end


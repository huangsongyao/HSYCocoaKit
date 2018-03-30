//
//  APPPathMacroFile.h
//  高仿暴走斗图
//
//  Created by key on 16/3/22.
//  Copyright © 2016年 huangsongyao. All rights reserved.
//

#ifndef APPPathMacroFile_h
#define APPPathMacroFile_h

//文件目录
#define kPATH_TEMP                  NSTemporaryDirectory()

//沙盒路径
#define kPATH_DOCUMENT              [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//缓存路径
#define kPATH_CACHE                 [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//库文件路径
#define kPATH_LIBRARY               [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//app目录
#define BUNDLE_PATH                 [[NSBundle mainBundle] bundlePath]

//视频缓存路径
#define CHANGE_VIDEO_PATH           [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define CHANGE_VIDEO_PATH_URL(path) [NSURL fileURLWithPath:path isDirectory:YES]


#endif /* APPPathMacroFile_h */

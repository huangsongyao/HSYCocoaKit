//
//  NetworkingRequestPathFile.h
//  高仿暴走斗图
//
//  Created by key on 16/3/24.
//  Copyright © 2016年 huangsongyao. All rights reserved.
//

#ifndef NetworkingRequestPathFile_h
#define NetworkingRequestPathFile_h

/**
 *  公开服务器及接口字段头文件，用于公开所有通用的接口字段和相关的url
 */

#ifdef DEBUG

#define BASE_URL                        @"http://192.168.1.12:8087/zbd-app"

#define SOCKET_HOST                     @"120.24.222.188"
#define SOCKET_PORT                     8383


#else

#define BASE_URL                        @"https://mobile.zhubaodai.com/zbd-app"

#define SOCKET_HOST                     @"120.24.222.188"
#define SOCKET_PORT                     8383

#endif

/**
 *  各个请求的字段
 */

#define POST_CONFIG                     @"user/getConfig"
#define POST_PAGE                       @""
#endif /* NetworkingRequestPathFile_h */

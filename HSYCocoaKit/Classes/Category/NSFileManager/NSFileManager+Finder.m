//
//  NSFileManager+Finder.m
//  Pods
//
//  Created by huangsongyao on 2018/3/30.
//
//

#import "NSFileManager+Finder.h"
#import "APPPathMacroFile.h"

@implementation NSFileManager (Finder)

+ (NSString *)finderFileFromResources:(NSArray<NSDictionary *> *)resources
{
    for (NSDictionary *paramter in resources) {
        NSString *filePath = [self.class finderFileFromName:paramter.allValues.firstObject fileType:paramter.allKeys.firstObject];
        if (filePath.length > 0) {
            return filePath;
        }
    }
    return nil;
}

+ (NSString *)finderFileFromName:(NSString *)name fileType:(NSString *)type
{
    NSString *resource = [self.class pathForResource:name fileType:type];
    NSString *doucment = [self.class pathForDocument:name fileType:type];
    NSString *cache = [self.class pathForCache:name fileType:type];
    NSString *library = [self.class pathForLibrary:name fileType:type];
    NSArray *paths = @[
                       resource,
                       doucment,
                       cache,
                       library,
                       ];
    for (NSString *path in paths) {
        if ([self.class fileExist:path]) {
            return path;
        }
    }
    return @"";
}

+ (BOOL)fileExist:(NSString *)name fileType:(NSString *)type
{
    NSString *path = [self.class finderFileFromName:name fileType:type];
    return (path.length > 0);
}

#pragma mark - File Is Downloaded

+ (BOOL)fileExist:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:filePath];
    return exist;
}

#pragma mark - File Path

+ (NSString *)pathForDocument:(NSString *)name fileType:(NSString *)type
{
    NSString *fileName = [NSString stringWithFormat:@"%@.%@", name, type];
    NSString *doucment = [NSString stringWithFormat:@"%@/%@", kPATH_DOCUMENT, fileName];
    if (!doucment) {
        doucment = @"";
    }
    return doucment;
}

+ (NSString *)pathForCache:(NSString *)name fileType:(NSString *)type
{
    NSString *fileName = [NSString stringWithFormat:@"%@.%@", name, type];
    NSString *cache = [NSString stringWithFormat:@"%@/%@", kPATH_CACHE, fileName];
    if (!cache) {
        cache = @"";
    }
    return cache;
}

+ (NSString *)pathForLibrary:(NSString *)name fileType:(NSString *)type
{
    NSString *fileName = [NSString stringWithFormat:@"%@.%@", name, type];
    NSString *library = [NSString stringWithFormat:@"%@/%@", kPATH_LIBRARY, fileName];
    if (!library) {
        library = @"";
    }
    return library;
}

+ (NSString *)pathForResource:(NSString *)name fileType:(NSString *)type
{
    NSString *pathResource = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if (!pathResource) {
        pathResource = @"";
    }
    return pathResource;
}


@end

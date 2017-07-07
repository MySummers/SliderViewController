//
//  WHSNetWorkTool.m
//  GiftToYou
//
//  Created by dllo on 15/12/1.
//  Copyright © 2015年 nishuaige. All rights reserved.
//

#import "WHSNetWorkTool.h"


@implementation WHSNetWorkTool

+ (void)getWithUrl:(NSString *)url parameter:(NSDictionary *)parameter httpHeader:(NSDictionary *)header responseType:(ResponseType)responseType success:(SuccessBlock)success fail:(FailedBlock)fail {
    
    
    
    //1.初始化sessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.处理请求头
    if (header) {
        for (NSString *key in header.allKeys) {
            [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
        }
    }
    //3.判断返回值数据类型
    switch (responseType) {
        case ResponseTypeDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case ResponseTypeJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case ResponseTypeXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
    }
    //4.判断返回值所接收的具体类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    //5.get请求
    
    NSString *resultStr = url;
    CFStringRef originalString = (__bridge CFStringRef)url;
    CFStringRef leaveUnescaped = CFSTR(" ");
    CFStringRef forceEscaped = CFSTR("!*'();@+$,#[]");
    CFStringRef escapedStr;
    
    escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                         originalString,
                                                         leaveUnescaped,
                                                         forceEscaped,
                                                         kCFStringEncodingUTF8);
    if(escapedStr)
    {
        NSMutableString *mutableStr = [NSMutableString stringWithString:(__bridge NSString *)escapedStr];
        CFRelease(escapedStr);
        
        // replace spaces with plusses
        [mutableStr replaceOccurrencesOfString:@" "
                                    withString:@""
                                       options:0
                                         range:NSMakeRange(0, [mutableStr length])];
        resultStr = mutableStr;
    }
    
    url = resultStr;
    
    [manager GET:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        if (success) {
            /* ************************************************** */
            //如果请求成功 , 回调请求到的数据 , 同时 在这里 做本地缓存
            NSString *path = [NSString stringWithFormat:@"%ld.plist", [url hash]];
            // 存储的沙盒路径
            NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            // 归档
            [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
            
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (fail) {
            fail(error);
        }
        
    }];
   
}


//httpHeader : @{@"token": AppToken, @"phoneType":IPhone,@"version":VerSion}
+ (void)postWithUrl:(NSString *)url body:(id)body bodyType:(BodyType)bodytype httpHeader:(NSDictionary *)header responseType:(ResponseType)responseType success:(SuccessBlock)success fail:(FailedBlock)fail {
    
    
    //1.初始化sessionManager
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:securityPolicy];
    //2.处理body
    switch (bodytype) {
        case BodyTypeDictionary:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case BodyTypeString:
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
                return parameters;
            }];
            break;
    }
    
    //3.处理请求头
    if (header) {
        for (NSString *key in header.allKeys) {
            [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
        }
    }
    //4.处理返回值类型
    switch (responseType) {
        case ResponseTypeDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case ResponseTypeJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case ResponseTypeXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
    }
    
    //5.判断返回值所接收的具体类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    //6.post请求                 
     
    NSString *resultStr = url;
    CFStringRef originalString = (__bridge CFStringRef)url;
    CFStringRef leaveUnescaped = CFSTR(" ");
    CFStringRef forceEscaped = CFSTR("!*'();@+$,#[]");
    CFStringRef escapedStr;
    
    escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                         originalString,
                                                         leaveUnescaped,
                                                         forceEscaped,
                                                         kCFStringEncodingUTF8);
    if(escapedStr)
    {
        NSMutableString *mutableStr = [NSMutableString stringWithString:(__bridge NSString *)escapedStr];
        CFRelease(escapedStr);
        
        // replace spaces with plusses
        [mutableStr replaceOccurrencesOfString:@" "
                                    withString:@""
                                       options:0
                                         range:NSMakeRange(0, [mutableStr length])];
        resultStr = mutableStr;
    }
    
    url = resultStr;
    
    [manager POST:url parameters:body success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            /* ************************************************** */
            //如果请求成功 , 回调请求到的数据 , 同时 在这里 做本地缓存
            NSString *path = [NSString stringWithFormat:@"%ld.plist", [url hash]];
            // 存储的沙盒路径
            NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            // 归档
            [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
          //  NSLog(@"%@",responseObject);
            success(responseObject);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            
            fail(error);
            
        }
    }];
   
}










@end

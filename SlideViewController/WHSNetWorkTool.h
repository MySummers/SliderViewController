//
//  WHSNetWorkTool.h
//  GiftToYou
//
//  Created by dllo on 15/12/1.
//  Copyright © 2015年 nishuaige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//请求成功的block类型
typedef void(^SuccessBlock)(id result);
//请求失败的block类型
typedef void(^FailedBlock)(NSError *error);

/**
 *  返回值类型
 */
typedef NS_ENUM(NSUInteger, ResponseType) {
    /**
     *  JSON类型
     */
    ResponseTypeJSON,
    /**
     *  XML类型
     */
    ResponseTypeXML,
    /**
     *  DATA类型
     */
    ResponseTypeDATA,
};

/**
 *  body类型
 */
typedef NS_ENUM(NSUInteger, BodyType) {
    /**
     *  字符串类型
     */
    BodyTypeString,
    /**
     *  字典类型
     */
    BodyTypeDictionary,
};






@interface WHSNetWorkTool : NSObject

/**
 *  get请求
 *
 *  @param url          网址
 *  @param parameter    参数
 *  @param header       请求头
 *  @param responseType 返回值类型
 *  @param success      成功响应
 *  @param fail         失败响应
 */
+ (void)getWithUrl:(NSString *)url parameter:(NSDictionary *)parameter httpHeader:(NSDictionary *)header responseType:(ResponseType)responseType success:(SuccessBlock)success fail:(FailedBlock)fail;


//post请求
/**
 *  post请求
 *
 *  @param url          网址
 *  @param body         body
 *  @param body         body类型
 *  @param header       请求头
 *  @param responseType 返回值类型
 *  @param success      成功响应
 *  @param fail         失败响应
 */
+ (void)postWithUrl:(NSString *)url body:(id)body bodyType:(BodyType)bodytype httpHeader:(NSDictionary *)header responseType:(ResponseType)responseType success:(SuccessBlock)success fail:(FailedBlock)fail;




// 图片处理

/**
 *  单图上传
 *
 *  @param url          网址
 *  @param body         body
 *  @param bodyType     body类型
 *  @param header       请求头
 *  @param image        图片
 *  @param responseType 返回值类型
 *  @param success      成功响应
 *  @param fail         失败响应
 */
+ (void)uploadImageWithUrl:(NSString *)url body:(id )body bodyType:(BodyType)bodyType httpHeader:(NSDictionary *)header Image:(UIImage *)image responseType:(ResponseType)responseType success:(SuccessBlock)success fail:(FailedBlock)fail;


@end

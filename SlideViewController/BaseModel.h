//
//  BaseModel.h
//  TangRenJie
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 whs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
@property (nonatomic, copy) NSString *ids;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
/**
 *  赋值
 *
 *  @param value JSONValue
 *  @param key    JSONKey
 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

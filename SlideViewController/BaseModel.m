//
//  BaseModel.m
//  TangRenJie
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 whs. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqual:@"id"]) {
        self.ids = [NSString stringWithFormat:@"%@",value];
    }
}
@end

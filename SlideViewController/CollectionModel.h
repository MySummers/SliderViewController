//
//  CollectionModel.h
//  NationalHealth
//
//  Created by 郑丽 on 2017/4/12.
//  Copyright © 2017年 ding _tk. All rights reserved.
//

#import "BaseModel.h"

@interface CollectionModel : BaseModel
// 标题
@property (nonatomic, copy) NSString  * title;
// 副标题
@property (nonatomic, copy) NSString  * bodyTitle;
// 图片
@property (nonatomic, copy) NSString  * coverUrl;
// 时间
@property (nonatomic, copy) NSString  * publishTime;
//
@property (nonatomic, copy) NSNumber  * delStatus;
// 类别标签
@property (nonatomic, copy) NSString  * labelName;
// 收藏数
@property (nonatomic, copy) NSNumber  * collectionsum;
// 浏览数
@property (nonatomic, copy) NSNumber  * scannum;
// 地址
@property (nonatomic, copy) NSString  * publishUrl;
// 内容
@property (nonatomic, copy) NSString  * content;
@end

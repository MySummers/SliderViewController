//
//  SubViewController.h
//  SlideViewController
//
//  Created by 周智勇 on 17/2/27.
//  Copyright © 2017年 周智勇. All rights reserved.
//

#import <UIKit/UIKit.h>
// 刷新
#import "MJRefresh.h"
// 自定义的header
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "MJChiBaoZiFooter2.h"
#import "MJDIYHeader.h"
#import "MJDIYAutoFooter.h"
#import "MJDIYBackFooter.h"


#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

#import "UIImageView+WebCache.h"


#import "WHSNetWorkTool.h"

#import "Header.h"

#import "HomeCell.h"
#import "CollectionModel.h"

@interface SubViewController : UIViewController
@property (nonatomic, copy) NSString  * metype;
@end

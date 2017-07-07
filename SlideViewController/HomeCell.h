//
//  HomeCell.h
//  NationalHealth
//
//  Created by ding _tk on 17/3/30.
//  Copyright © 2017年 ding _tk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"
#import "UIImageView+WebCache.h"
#import "Header.h"


@interface HomeCell : UITableViewCell

@property (nonatomic, strong) CollectionModel  * model;



@property (weak, nonatomic) IBOutlet UIImageView *IMG;

@property (weak, nonatomic) IBOutlet UILabel *about;

@property (weak, nonatomic) IBOutlet UILabel *CreatTime;

@property (weak, nonatomic) IBOutlet UILabel *LookCount;
@property (weak, nonatomic) IBOutlet UILabel *LikesCount;

@property (weak, nonatomic) IBOutlet UIImageView *LikeImg;
@property (weak, nonatomic) IBOutlet UIImageView *LookImg;
@property (weak, nonatomic) IBOutlet UILabel *SortLab;

@end

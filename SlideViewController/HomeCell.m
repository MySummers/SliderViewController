//
//  HomeCell.m
//  NationalHealth
//
//  Created by ding _tk on 17/3/30.
//  Copyright © 2017年 ding _tk. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setModel:(CollectionModel *)model{

    if (_model != model) {
        _model = model;
    }

     [_IMG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER,model.coverUrl]] placeholderImage:[UIImage imageNamed:@"qs_loser"]];

    _IMG.contentMode = UIViewContentModeScaleAspectFill;
    _IMG.clipsToBounds = YES;
    _about.text = model.title;
    _SortLab.text = model.labelName;
    _LikesCount.text = [NSString stringWithFormat:@"收藏:%@",model.collectionsum.stringValue];
    _LookCount.text = [NSString stringWithFormat:@"阅读:%@",model.scannum.stringValue];
    _CreatTime.text = model.publishTime;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

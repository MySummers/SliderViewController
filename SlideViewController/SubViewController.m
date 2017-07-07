//
//  SubViewController.m
//  SlideViewController
//
//  Created by 周智勇 on 17/2/27.
//  Copyright © 2017年 周智勇. All rights reserved.
//

#import "SubViewController.h"
#import "TestPushViewController.h"
#define RandColor RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
@interface SubViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray  * dataSource;
@property (nonatomic, strong) NSMutableArray  * DataAllsource;
@property(nonatomic)int showCount;//上拉加载更多
@property(nonatomic)int currentPage;
@property (nonatomic, copy) NSNumber  * AllcountPage;
@property (nonatomic, strong) UIView * HeadView;
@property (nonatomic, strong) UIImageView * HeadImg;
@property (nonatomic, strong) UILabel  * TitleLab;
@property (nonatomic, strong) UIView  * labView;
@property (nonatomic, copy) NSString  * DetialID;
@property (nonatomic, copy) NSString  * DetialUrl;
@property (nonatomic, copy) NSString  * DetialContent;
@property (nonatomic, copy) NSString  * mainTitle;
@property (nonatomic, copy) NSString  * SubtitleContent;

@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView{
    
    _showCount = 10;
    _currentPage = 1;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-104)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
    
    _HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenWidth/2)];
    _tableView.tableHeaderView = _HeadView;
    _HeadImg = [[UIImageView alloc]initWithFrame:_HeadView.bounds];
    [_HeadView addSubview:_HeadImg];
    _HeadImg.userInteractionEnabled=YES;
    _HeadImg.contentMode = UIViewContentModeScaleAspectFill;
    _HeadImg.clipsToBounds = YES;
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickedDetial)];
    [_HeadImg addGestureRecognizer:tapGesturRecognizer];
    
    _labView = [[UIView alloc]initWithFrame:CGRectMake(0, MainScreenWidth/2-30*FitHeight, MainScreenWidth, 30*FitHeight)];
    _TitleLab = [[UILabel alloc]initWithFrame:CGRectMake(10*FitWidth, 0, MainScreenWidth-20*FitWidth, 30)];
    _TitleLab.font = [UIFont systemFontOfSize:15];
    _TitleLab.textColor = [UIColor whiteColor];
    _TitleLab.textAlignment = NSTextAlignmentRight;
    [_HeadImg addSubview:_labView];
    [_labView addSubview:_TitleLab];
    
    _DataAllsource = [NSMutableArray array];
    [self refresh];
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self RequestDataList:_metype];
        
    });
    
}

#pragma mark ===========刷新===========
- (void)refresh{
    
    //    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    //    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(pull)];
    //
    //    // 隐藏时间
    //    header.lastUpdatedTimeLabel.hidden = YES;
    //
    //    // 隐藏状态
    //    header.stateLabel.hidden = YES;
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pull)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置header
    self.tableView.mj_header = header;
    
    // 上拉加载更多
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(push)];
    
}

- (void)pull{
    
    _currentPage = 1;
    _DataAllsource = [NSMutableArray array];
    [self RequestDataList:_metype];
    
}

- (void)push{
    
    if (_currentPage < _AllcountPage.integerValue) {
        _currentPage ++;
        [self RequestDataList:_metype];
    } else{
        
        [_tableView reloadData];
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
    
    
}


#pragma mark - 资讯列表
- (void)RequestDataList:(NSString *)types{
   
    _dataSource = [NSMutableArray array];
    NSString * string = [NSString stringWithFormat:@"phone=%@&page=%d&size=%@&type=%@",@"1",_currentPage,@"10",types];
    
    [WHSNetWorkTool postWithUrl:Url(HealthList_Url) body:string bodyType:0 httpHeader:nil responseType:0 success:^(id result) {
        
        if ([result[@"resultCode"] integerValue] != 200) {
            
            [_tableView reloadData];
            // 拿到当前的上拉刷新控件，结束刷新状态
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
            return ;
        }
        _AllcountPage = result[@"count"];
        NSDictionary * HotDic = result[@"value"][@"featured"];
        [_HeadImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER,HotDic[@"coverUrl"]]] placeholderImage:[UIImage imageNamed:@"qs_jiazai_big"]];
        _DetialID = [HotDic[@"id"] stringValue];
        _DetialUrl = HotDic[@"publishUrl"];
        _DetialContent = HotDic[@"content"];
        _mainTitle = HotDic[@"title"];
        _SubtitleContent = HotDic[@"bodyTitle"];
        _TitleLab.text = HotDic[@"title"];
        _labView.backgroundColor = [UIColor blackColor];
        NSArray * ary = result[@"value"][@"list"];
        for (NSDictionary * dic in ary) {
            CollectionModel * model = [[CollectionModel alloc]initWithDictionary:dic];
            [_dataSource addObject:model];
        }
        
        if (!_dataSource.count) {
           
        }
        for (CollectionModel * model in _dataSource) {
            [_DataAllsource addObject:model];
        }
        
        [_tableView reloadData];
        // 拿到当前的上拉刷新控件，结束刷新状态
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    } fail:^(NSError *error) {
        
    }];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _DataAllsource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeCell" owner:self options:nil]lastObject];
    }
    if (_DataAllsource.count) {
        cell.model = _DataAllsource[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 95*FitHeight;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionModel * model = [[CollectionModel alloc]init];
    
    if (_dataSource.count) {
        model = _DataAllsource[indexPath.row];
    }
//    ConsultationViewController * DetialVc = [[ConsultationViewController alloc]init];
//    DetialVc.hidesBottomBarWhenPushed = YES;
//    DetialVc.UrlStr = model.publishUrl;
//    DetialVc.content = model.content;
//    DetialVc.InformationId = model.ids;
//    DetialVc.mainTitle = model.title;
//    DetialVc.SubtitleContent = model.bodyTitle;
//    model.scannum = [NSNumber numberWithInteger:model.scannum.integerValue + 1];
//    [_tableView reloadData];
//    [self.navigationController pushViewController:DetialVc animated:YES];
    
}

- (void)ClickedDetial{
    
//    ConsultationViewController * DetialVc = [[ConsultationViewController alloc]init];
//    DetialVc.hidesBottomBarWhenPushed = YES;
//    DetialVc.UrlStr = _DetialUrl;
//    DetialVc.content = _DetialContent;
//    DetialVc.InformationId = _DetialID;
//    [self.navigationController pushViewController:DetialVc animated:YES];
    
}
//设置分割线上下去边线，顶头缩进15
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets UIEgde = UIEdgeInsetsMake(0, 10, 0, 10);
    
    
    if (indexPath.section == (_dataSource.count)-1) {
        cell.preservesSuperviewLayoutMargins = NO;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.separatorInset = UIEdgeInsetsMake(0,MainScreenWidth, 0, 0);
    }else{
        [cell setSeparatorInset:UIEgde];
        
    }
}

@end

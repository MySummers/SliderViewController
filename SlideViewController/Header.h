//
//  Header.h
//  SlideViewController
//
//  Created by IOS on 2017/4/26.
//  Copyright © 2017年 周智勇. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define MainScreenWidth [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height

#define FitWidth [[UIScreen mainScreen] bounds].size.width / 375
#define FitHeight [[UIScreen mainScreen] bounds].size.height / 667

#define Url(string) [NSString stringWithFormat:@"%@%@", URL_HEADER, string]
// 正式
#define URL_HEADER @"http://211.144.155.50:8080/"

// 首页资讯列表
#define HomeInformation_Url @"api/1/showindexinformation"

#define HealthList_Url @"api/1/showinformationlist"

#define IphoneAndVersion [NSString stringWithFormat:@"phoneType=%@&version=%@",IPhone,VerSion]


#endif /* Header_h */

//
//  WeiboManager.m
//  假微博
//
//  Created by yangqinglong on 16/3/29.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "WeiboManager.h"
#import "WeiboModel.h"
//用于userdefault里面accessTokenKey
#define kAccessTokenKey @"kAccessTokenKey"
#define kRefreshTokenKey @"kRefreshTokenKey"
#define kUserIDKey @"kUserIDKey"
//用于区分到底是哪个request回调数据
#define kGetTokenInfoTag @"kGetTokenInfoTag"
#define kDownloadWeiboInfoTag @"kDownloadWeiboInfoTag"

static WeiboManager *instance = nil;
@interface WeiboManager()<WBHttpRequestDelegate>
@property (nonatomic,copy) loadWeiboDataBlock finishedBlock;
@end


@implementation WeiboManager
+(instancetype)shareManager{
    if (instance == nil) {
        instance = [[super allocWithZone:NULL]init];
    }
    return instance;
//    static WeiboManager *instance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [[WeiboManager alloc] init];
//    });
//    return instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self shareManager];
}
-(void)WeiboLogin{
    //授权认证
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURL;
    [WeiboSDK sendRequest:request];
}

-(void)WeiboLogOut{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:kAccessTokenKey];
    [userDefaults setObject:nil forKey:kRefreshTokenKey];
    [userDefaults setObject:nil forKey:kUserIDKey];
    [userDefaults synchronize];
}
#pragma mark ---------重写get方法
-(NSString *)accessToken{
    //从userdefault里面读取
    return [[NSUserDefaults standardUserDefaults]objectForKey:kAccessTokenKey];
}
//检查accessToken是否过期
-(void)checkAccessTokenInfo{
    [WBHttpRequest requestWithAccessToken:self.accessToken url:@"https://api.weibo.com/oauth2/get_token_info" httpMethod:@"POST" params:nil delegate:self withTag:kGetTokenInfoTag];
}

-(BOOL)isLogined{
    if (self.accessToken.length == 0) {
        return NO;
    }else{
        [self checkAccessTokenInfo];
        return YES;
    }
}
#pragma mark ---------WBHttpRequsetDelegate
-(void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    //json格式的数据转化为字典
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //判断到底是哪个请求
    if ([request.tag isEqualToString:kGetTokenInfoTag]) {
        //获取accessToken 信息
        [self parseAccessTokenInfo:resultDic];
    }
    //获取微博好友信息
    if ([request.tag isEqualToString:kDownloadWeiboInfoTag]) {
        [self parseWeiboInfo:resultDic];
    }
    
}
//解析微博信息
-(void)parseWeiboInfo:(NSDictionary *)info{
    NSArray *weiboDicArray = [info objectForKey:@"statuses"];
    //保存所有微博的Model
    NSMutableArray *weiboModelsArray = [NSMutableArray array];
    for (NSDictionary *weiboDic in weiboDicArray) {
        //创建一个model
        WeiboModel *model = [[WeiboModel alloc]init];
        [model setWithDictionary:weiboDic];
        //将模型添加到数组里面
        [weiboModelsArray addObject:model];
    }
    //回调数据
    self.finishedBlock(weiboModelsArray);
}
//解析accessToken信息
/*
 {
 "uid": 1073880650,
 "appkey": 1352222456,
 "scope": null,
 "create_at": 1352267591,
 "expire_in": 157679471
 }
 */
-(void)parseAccessTokenInfo:(NSDictionary *)info{
    //获取创建和过期时间
    NSUInteger create_at = [[info objectForKey:@"create_at"] unsignedIntegerValue];
    NSUInteger expire_in = [[info objectForKey:@"expire_in"] unsignedIntegerValue];
    //获取现在时间
    NSUInteger nowTime = [[NSDate date] timeIntervalSince1970];
    //判断是否过期
    if (nowTime >(create_at + expire_in)) {
        //过期了 重新登录
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:kAccessTokenKey];
        [self WeiboLogin];
    }
}

#pragma mark --------weiboSDKDelegate 
-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[response.userInfo objectForKey:@"access_token"]forKey:kAccessTokenKey];
    [userDefaults setObject:[response.userInfo objectForKey:@"refresh_token"]forKey:kRefreshTokenKey];
    [userDefaults setObject:[response.userInfo objectForKey:@"uid"] forKey:kUserIDKey];
    [userDefaults synchronize];
    
}
-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}
#pragma mark ---------下载微博内容
-(void)loadWeiboInfo:(loadWeiboDataBlock)block{
    self.finishedBlock = block;
    [WBHttpRequest requestWithAccessToken:self.accessToken url:@"https://api.weibo.com/2/statuses/friends_timeline.json" httpMethod:@"GET" params:@{@"count":@"50"} delegate:self withTag:kDownloadWeiboInfoTag];
}

-(void)sendWeiboWithText:(NSString *)text{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *data = [text dataUsingEncoding:enc];
    NSString *retStr = [[NSString alloc]initWithData:data encoding:enc];
    NSDictionary *parasDic = @{@"access_token":[WeiboManager shareManager].accessToken,@"status":retStr};
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/statuses/update.json" httpMethod:@"POST" params:parasDic queue:[[NSOperationQueue alloc]init] withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        self.WeiboSendIsFinishedBlock();
    }];

}

-(void)sendWeiboWithText:(NSString *)text Pic:(NSData *)picData{
    NSString *encodedString = [text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""]];
    NSDictionary *paramDic = @{@"access_token":[[NSUserDefaults standardUserDefaults]objectForKey:kAccessTokenKey],@"status":encodedString,@"pic":picData};
    [WBHttpRequest requestWithURL:@"https://upload.api.weibo.com/2/statuses/upload.json" httpMethod:@"POST" params:paramDic queue:[[NSOperationQueue alloc]init] withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        self.WeiboSendIsFinishedBlock();
    }];

}

@end















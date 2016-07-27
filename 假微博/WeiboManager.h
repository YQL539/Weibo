//
//  WeiboManager.h
//  假微博
//
//  Created by yangqinglong on 16/3/29.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^loadWeiboDataBlock)(NSArray *modelsArray);
typedef void (^WeiboSendIsFinished)(void);

@interface WeiboManager : NSObject<WeiboSDKDelegate>
/**accessToken */
@property (nonatomic,copy) NSString *accessToken;

/**是否已经登录 */
@property (nonatomic,assign) BOOL isLogined;

@property(nonatomic,copy) WeiboSendIsFinished WeiboSendIsFinishedBlock;
/**登录 */
-(void)WeiboLogin;
/**退出登录 */
-(void)WeiboLogOut;
/**单列 */
+(instancetype)shareManager;

/**下载微博内容 */
-(void)loadWeiboInfo:(loadWeiboDataBlock)block;
-(void)sendWeiboWithText:(NSString *)text;
-(void)sendWeiboWithText:(NSString *)text Pic:(NSData *)picData;

@end













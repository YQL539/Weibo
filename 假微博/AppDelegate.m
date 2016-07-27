//
//  AppDelegate.m
//  假微博
//
//  Created by yangqinglong on 16/3/28.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "DDMenuController.h"
#import "LeftViewController.h"
#import "MassageViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"
#import "YQLTabController.h"
#import "ThemeTabBarItem.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建 窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //创建程序启动之后的主页
    HomeViewController *hvc = [[HomeViewController alloc]init];
    //创建DDmenu
    DDMenuController *menuCtrl = [[DDMenuController alloc]initWithRootViewController:hvc];
    menuCtrl.backgroundImageName = @"tabbar_background";
    //配置左右控制器
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    LeftViewController *leftCtrl = [storyboard instantiateViewControllerWithIdentifier:@"leftView"];
    leftCtrl.title = @"主题";
    menuCtrl.leftController = leftCtrl;

    //创建TabBarController
    YQLTabController *tabController = [[YQLTabController alloc]init];
    tabController.tabBar.tintColor = [UIColor orangeColor];
    
    //创建tabBar上面管理的界面
    //创建主页
    menuCtrl.tabBarItem = [ThemeTabBarItem themeTabBarItemWithTitle:@"首页" normalImageName:@"tabbar_home"selectedImageName:@"tabbar_home_selected"];
    //消息页面
    MassageViewController *msgVC = [[MassageViewController alloc]init];
    msgVC.tabBarItem = [ThemeTabBarItem themeTabBarItemWithTitle:@"消息" normalImageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    //发现页面
    DiscoverViewController *dscVC = [[DiscoverViewController alloc]init];
    dscVC.view.backgroundColor = [UIColor whiteColor];
    dscVC.tabBarItem = [ThemeTabBarItem themeTabBarItemWithTitle:@"发现" normalImageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    
    //我页面
    ProfileViewController *meVC = [[ProfileViewController alloc]init];
    meVC.view.backgroundColor = [UIColor whiteColor];
    meVC.tabBarItem = [ThemeTabBarItem themeTabBarItemWithTitle:@"我" normalImageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    
    //将创建的HomeVc添加到Tabbarviewcontroller 上
    tabController.viewControllers = @[menuCtrl,msgVC,dscVC,meVC];
    //设置窗口的根视图控制器
    self.window.rootViewController  = tabController;
//    NSLog(@"%@",[[NSBundle mainBundle]resourcePath]);//查看app在虚拟机中的储存位置
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    //显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    return [WeiboSDK handleOpenURL:url delegate:[WeiboManager shareManager]];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

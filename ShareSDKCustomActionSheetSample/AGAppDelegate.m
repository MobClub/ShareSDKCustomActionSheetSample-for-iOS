//
//  AGAppDelegate.m
//  ShareSDKCustomActionSheetSample
//
//  Created by Nogard on 13-10-10.
//  Copyright (c) 2013年 ShareSDK. All rights reserved.
//

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "AGAppDelegate.h"
#import "AGShareSDKSampleViewController.h"

@implementation AGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [ShareSDK registerApp:@"api20"];

    [ShareSDK connectSinaWeiboWithAppKey:@"3201194191"
                               appSecret:@"0334252914651e8f76bad63337b3b78f"
                             redirectUri:@"http://appgo.cn"];

    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                redirectUri:@"http://www.sharesdk.cn"];

    [ShareSDK connectQQWithQZoneAppKey:@"100371282"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];

    [ShareSDK connectWeChatWithAppId:@"wx6dd7a9b94f3dd72a"
                           wechatCls:[WXApi class]];

    AGShareSDKSampleViewController *rootVC = [[AGShareSDKSampleViewController alloc] init];

    self.window.rootViewController = rootVC;

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (BOOL)application:(UIApplication *)application  handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

@end

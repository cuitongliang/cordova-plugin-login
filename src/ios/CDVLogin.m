

#import <Cordova/CDV.h>
#import "CDVLogin.h"
#import <UMSocialCore/UMSocialCore.h>

@implementation CDVLogin

- (void)pluginInitialize
{
    NSLog(@"初始化登录相关的配置");
    [self confitUShareSettings];
    [self configUSharePlatforms];
}

/**
 * 友盟社会化分享配置
 * 1. 打开调试日志
 * 2. 设置友盟APPKEY
 * 3. 获取友盟版本号
 */
- (void)confitUShareSettings{
    
    /* 打开日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    // 打开图片水印
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = YES;//?
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"51662ca956240b630d001e43"];
    NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
}

/**
 * 友盟社会化分享平台
 * 友盟社会化分享各平台SSO集成方法：(微信、QQ、新浪微博三个)
 * 1. 设置微信的appKey和appSecret
 * 2. 设置分享到QQ互联的appKey和appSecret
 * 3. 设置新浪的appKey和appSecret
 *
 */
- (void)configUSharePlatforms {
    //微信
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:@"wxa5b1b85d5c4fd9c3"
                                       appSecret:@"64d13b75110ed80d46b4b5631d74145c" redirectURL:@"http://mobile.umeng.com/social"];
    
    //QQ
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:@"1101095229"
                                       appSecret:nil
                                     redirectURL:@"http://mobile.umeng.com/social"];
    //新浪
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina
                                          appKey:@"996575171"//@"3921700954"
                                       appSecret:@"038c499727622ecdc6d0251e296b078d"
                                     redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}


//QQ信任登录
- (void)qq:(CDVInvokedUrlCommand*)command{
    [self getUserInfoWithPlatform:UMSocialPlatformType_QQ];
}
//新浪信任登录
- (void)sina:(CDVInvokedUrlCommand*)command{
     [self getUserInfoWithPlatform:UMSocialPlatformType_Sina];
}
//微信信任登录
- (void)weixin:(CDVInvokedUrlCommand*)command{
    [self getUserInfoWithPlatform:UMSocialPlatformType_WechatSession];
}
//支付宝信任登录
- (void)alipay:(CDVInvokedUrlCommand*)command{
    //TODO
    //[self getUserInfoWithPlatform:UMSocialPlatformType_AlipaySession];
}

//QQ客户端是否安装
- (void)isQQInstall:(CDVInvokedUrlCommand*)command{

    [self isPlatformInstall:UMSocialPlatformType_QQ command:command];
}
//新浪客户端是否安装
- (void)isSinaInstall:(CDVInvokedUrlCommand*)command{
    [self isPlatformInstall:UMSocialPlatformType_Sina command:command];
}

//微信客户端是否安装
- (void)isWeixinInstall:(CDVInvokedUrlCommand*)command{
    [self isPlatformInstall:UMSocialPlatformType_WechatSession command:command];
}

//支付宝客户端是否安装
- (void)isAlipayInstall:(CDVInvokedUrlCommand*)command{
    [self isPlatformInstall:UMSocialPlatformType_AlipaySession command:command];
}

//判断第三方客户端是否安装
- (void) isPlatformInstall:(UMSocialPlatformType)platformType command:(CDVInvokedUrlCommand*)command{
    NSString* info = [[UMSocialManager defaultManager] isInstall:platformType]?@"true":@"false";
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:info];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


//获取平台授权信息以及用户信息
-(void)getUserInfoWithPlatform:(UMSocialPlatformType)platformType{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            //TODO
            NSLog(@"授权 error");
        } else {
            NSLog(@"success");
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            //NSLog(@"uid: %@", resp.uid);
            //NSLog(@"openid: %@", resp.openid);
            //NSLog(@"accessToken: %@", resp.accessToken);
            //NSLog(@"expiration: %@", resp.expiration);
            
            // 用户信息
            //NSLog(@"name: %@", resp.name);
            //NSLog(@"iconurl: %@", resp.iconurl);
            //NSLog(@"gender: %@", resp.gender);
            
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
        }
    }];
    
}

@end

#import <Cordova/CDVPlugin.h>

@interface CDVLogin : CDVPlugin

- (void)qq:(CDVInvokedUrlCommand*)command;
- (void)sina:(CDVInvokedUrlCommand*)command;
- (void)weixin:(CDVInvokedUrlCommand*)command;
- (void)alipay:(CDVInvokedUrlCommand*)command;

- (void)isQQInstall:(CDVInvokedUrlCommand*)command;
- (void)isSinaInstall:(CDVInvokedUrlCommand*)command;
- (void)isWeixinInstall:(CDVInvokedUrlCommand*)command;
- (void)isAlipayInstall:(CDVInvokedUrlCommand*)command;


@end

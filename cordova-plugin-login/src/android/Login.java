package org.apache.cordova.login;

import android.app.Activity;
import android.content.Intent;
import android.widget.Toast;

import com.umeng.socialize.UMAuthListener;
import com.umeng.socialize.UMShareAPI;
import com.umeng.socialize.UMShareConfig;
import com.umeng.socialize.bean.SHARE_MEDIA;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;

import java.util.Map;

/**
 * Created by cuitongliang on 2017/5/2.
 */

public class Login extends CordovaPlugin {
    private Activity mContext;

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        mContext =  this.cordova.getActivity();
    }

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {
        if ("qq".equals(action)) {getUserInfoWithPlatform(SHARE_MEDIA.QQ,callbackContext);return true;}
        if ("sina".equals(action)) {getUserInfoWithPlatform(SHARE_MEDIA.SINA,callbackContext);return true;}
        if ("weixin".equals(action)) {getUserInfoWithPlatform(SHARE_MEDIA.WEIXIN,callbackContext);return true;}
        if ("alipay".equals(action)) {getUserInfoWithPlatform(SHARE_MEDIA.ALIPAY,callbackContext);return true;}
        if ("isQQInstall".equals(action)){callbackContext.success(isPlatformInstall(SHARE_MEDIA.QQ,callbackContext));return true;}
        if ("isSinaInstall".equals(action)){callbackContext.success(isPlatformInstall(SHARE_MEDIA.SINA,callbackContext));return true;}
        if ("isWeixinInstall".equals(action)){callbackContext.success(isPlatformInstall(SHARE_MEDIA.WEIXIN,callbackContext));return true;}
        if ("isAlipayInstall".equals(action)){callbackContext.success(isPlatformInstall(SHARE_MEDIA.ALIPAY,callbackContext));return true;}
        return false;
    }

    //获取平台信息
    private void getUserInfoWithPlatform(SHARE_MEDIA platform,final CallbackContext callbackContext){
        cordova.setActivityResultCallback(this);//为了回调
        UMShareConfig config = new UMShareConfig();
        config.isNeedAuthOnGetUserInfo(true);//三方登录时是否每次都要进行授权
        config.setSinaAuthType(UMShareConfig.AUTH_TYPE_SSO);//当安装的时候进行SSO授权
        //config.setSinaAuthType(UMShareConfig.AUTH_TYPE_WEBVIEW); //调用此接口后，无论用户设备是否安装微博客户端，都只会拉起网页授权
        UMShareAPI.get(mContext).setShareConfig(config);
        UMShareAPI.get(mContext).getPlatformInfo(mContext, platform, new UMAuthListener() {
            @Override
            public void onComplete(SHARE_MEDIA platform, int action, Map<String, String> info) {
                if (info!=null){
                    Toast.makeText(mContext,info.toString(),Toast.LENGTH_LONG).show();
                    callbackContext.success(info.toString());
                }
            }

            @Override
            public void onError(SHARE_MEDIA platform, int action, Throwable t) {
                Toast.makeText( mContext, "get fail"+t.getMessage(), Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onCancel(SHARE_MEDIA platform, int action) {
                Toast.makeText(mContext,"取消分享",Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onStart(SHARE_MEDIA arg0) {
                Toast.makeText(mContext,"开始分享",Toast.LENGTH_SHORT).show();

            }
        });

    }

    //判断是否安装客户端
    private String isPlatformInstall(SHARE_MEDIA platform,CallbackContext callbackContext){
       return String.valueOf(UMShareAPI.get(mContext).isInstall(mContext,platform));
    }


    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        UMShareAPI.get(mContext).onActivityResult(requestCode, resultCode, data);
    }


    @Override
    public void onDestroy() {
        super.onDestroy();
        UMShareAPI.get(mContext).release();
    }
}

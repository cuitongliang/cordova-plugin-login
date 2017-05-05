var exec = require('cordova/exec');

var login = {

    qq:function() {
        exec(null, null, "Login", "qq", []);
    },

    sina:function() {
        exec(null, null, "Login", "sina", []);
    },

    weixin:function() {
        exec(null, null, "Login", "weixin", []);
    },

    alipay:function() {
        exec(null, null, "Login", "alipay", []);
    },

    isQQInstall:function(success){
        exec(success, null, "Login", "isQQInstall", []);
    },

    isSinaInstall:function(success){
            exec(success, null, "Login", "isSinaInstall", []);
    },

    isWeixinInstall:function(success){
            exec(success, null, "Login", "isWeixinInstall", []);
    },

    isAlipayInstall:function(success){
            exec(success, null, "Login", "isAlipayInstall", []);
    }

};

module.exports = login;

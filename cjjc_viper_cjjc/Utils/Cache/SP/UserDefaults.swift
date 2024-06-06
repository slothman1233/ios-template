//
//  UserDefaults.swift
//  SwiftTest
//
//  Created by apple on 2018/7/14.
//  Copyright © 2018年 KaoLaMall. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults
extension DefaultsKeys {
    
    /**--------------------------- ip地址 ---------------------------*/
    var ip : DefaultsKey<String>{.init("ip",defaultValue: "0,0,0,0")}
    
    /**--------------------------- 网络类型 ---------------------------*/
    var netType : DefaultsKey<String>{.init("netType",defaultValue: "wifi")}
    
    /**---------------------------uuid ---------------------------*/
    var uuid : DefaultsKey<String>{.init("uuid",defaultValue: UIDevice.current.identifierForVendor?.uuidString ?? "")}
    
    /** **********  用户名  *********** */
    var userName : DefaultsKey<String?>{.init("userName")}
    
    /** **********  密码  *********** */
    var pw : DefaultsKey<String?>{.init("pw")}
    
    /** **********  语言  *********** */
    var userLanguage : DefaultsKey<String>{.init("userLanguage",defaultValue: "en")}
    
    /** **********  个人信息  *********** */
    var userInfo : DefaultsKey<UserInfo?>{.init("userInfo")}
    
    /** **********  配置  *********** */
    var sysConfigModel : DefaultsKey<SysConfigModel?>{.init("sysConfigModel")}
    
    /** ********** 是否登录  *********** */
    var isLogin : DefaultsKey<Bool>{.init("isLogin", defaultValue: false)}
    
    /** **********  长连接相关  *********** */
    var socketID : DefaultsKey<String>{.init("socketID",defaultValue: "")}
    
    /** ********** 长连接相关  *********** */
    var socketToken : DefaultsKey<String>{.init("socketToken",defaultValue: "")}
    
    /** **********  key  *********** */
    var key : DefaultsKey<String>{.init("key",defaultValue: "")}
    
    /** **********  是否开启推送  *********** */
    var status : DefaultsKey<String>{.init("status", defaultValue: "0")}
    
    /** **********  闪退用户名数组  *********** */
    var userArr : DefaultsKey<[String]>{.init("userArr", defaultValue: ["l123"])}
    
    /** **********  是否闪退  *********** */
    var crash : DefaultsKey<String>{.init("crash",defaultValue: "")}
    
    /** **********    *********** */
    var user_login : DefaultsKey<String>{.init("user_login", defaultValue: "")}
    
    
    
    var mobile : DefaultsKey<String>{.init("mobile", defaultValue: "")}
    
}

class UserInfo: HandyJSON ,Codable,DefaultsSerializable{

    var avatar: String?
    var createTime: String?
    var id: String?
    var inviteCode: String?
    var inviteUser: String?
    var lastLoginIp: String?
    var level: String?
    var nickName: String?
    var oldPhone: String?
    var phone: String?
    var registerSource: String?
    var sex: String?
    var status: String?
    var token: String?
    var tureName: String?
    var payPassword: Bool = false
//    (0未提交实名 1实名中 2已实名 3审核失败)
    var verifyStatus: Int?
    var androidAddress: String?
    var iosAddress: String?

    public static var _defaults: DefaultsCodableBridge<UserInfo> { return DefaultsCodableBridge<UserInfo>() }
    public static var _defaultsArray: DefaultsCodableBridge<[UserInfo]> { return  DefaultsCodableBridge<[UserInfo]>() }
    
    required init() {}
}



class SysConfigModel: HandyJSON ,Codable,DefaultsSerializable{
    var configValue : String = "off"
    var open_active : ActiveModel?
    
    public static var _defaults: DefaultsCodableBridge<SysConfigModel> { return DefaultsCodableBridge<SysConfigModel>() }
    public static var _defaultsArray: DefaultsCodableBridge<[SysConfigModel]> { return  DefaultsCodableBridge<[SysConfigModel]>() }
    
    required init() {}
}

class ActiveModel: HandyJSON ,Codable,DefaultsSerializable{
    var configKey: String?
    var configName: String?
    var configValue: String = "off"
    
    public static var _defaults: DefaultsCodableBridge<ActiveModel> { return DefaultsCodableBridge<ActiveModel>() }
    public static var _defaultsArray: DefaultsCodableBridge<[ActiveModel]> { return  DefaultsCodableBridge<[ActiveModel]>() }
    required init() {}
}

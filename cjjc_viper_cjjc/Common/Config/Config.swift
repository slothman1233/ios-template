//
//  Config.swift
//  Viper
//
//  Created by cjjc on 2022/7/29.
//

import Foundation

typealias VoidCallback = () -> ()
typealias IndexCallback = (_ index: NSInteger) -> Void
typealias BoolCallback = (_ ret: Bool) -> Void

typealias SuccessBlock = ((_ model: BaseModel) -> Void)?
typealias FailBlcok = ((_ error : Error?) -> Void)?

enum RefreshState : Int {
    case refresh = 0
    case loadMore = 1
}

enum WalletState : Int {
    case balance = 0
    case integral = 1
}

/// 充值， 提现， 佣金。记录
enum MoneyOperate : Int {
    case charge = 0
    case withdraw = 1
    case commission = 2
}


struct Config {
    // MARK: -  微信公众平台
    static let wx_app_id = "wxeb65021f08bf3bc9"
    static let wx_app_secret = "6d95b16fc85828b0b3c36288cfc3dfff"
    static let wx_universalLink = "https://afc53e288d5c836f11ae5ce4c2005f9c.share2dlink.com/"

    // MARK: -  多亮sdk相关
    static let dl_app_id = "dy_59639384"
    static let dl_app_sectet = "6b7abbad9bb02b32039071c0261b3bd7"
    
    
    // MARK: -  闪游盒子
    static let sy_channnel_id = "357"
    static let sy_secret_key = "e9b8db156f11454582f40d8192c8bb0d"
    
    // MARK: -  视频广告
    static let fn_appid     = "421328275596386304"
    static let fn_adsidkp   = "421328881920774144"
    static let fn_adsidcp   = "421328920856502272"
    static let fn_adsicfullcp = "558610433414533121"
    static let fn_adsidjls  = "421328963747454976"
    static let fn_adsidhf   = "421329004218290176"
    static let fn_adsidxxl  = "421329042273210368"
    static let fn_adsidvxxl = "490868721208791040"
    
    // MARK: -  转钱
    static let zq_key_id = "659559074148"
    static let zq_sale_Id = "787209"
    
    
    // MARK: -  url缓存标记
    static let yida_cache_mark = "yiDaCacheMark"
    
}

//
//  CacheKey.swift
//  YiDa
//
//  Created by cjjc on 2022/8/4.
//

import Foundation

class CacheManage{
    /// 将参数字典转换成字符串后md5
   class func cacheKey(_ url: String, _ params: [String: Any]?) -> String {
        /// #29 参数过滤bug
        /// 参数重复, `params`中过滤掉`dynamicParams`中的参数
        let params = params ?? [:]
        var filterParams: [String: Any] = [:]
        
        for param in params {
            filterParams[param.key] = param.value
        }
        
        if filterParams.keys.count > 0 {
            let str = "\(url)" + "\(sort(filterParams))"
            return str.md5() + Config.yida_cache_mark
        } else {
            return url.md5() + Config.yida_cache_mark
        }
    }
    
    /// 将参数字典转换成字符串后md5 时间戳key
   class func cacheTimeKey(_ url: String, _ params: [String: Any]?) -> String {
        /// #29 参数过滤bug
        /// 参数重复, `params`中过滤掉`dynamicParams`中的参数
        let params = params ?? [:]
        var filterParams: [String: Any] = [:]
        
        for param in params {
            filterParams[param.key] = param.value
        }
        
        if filterParams.keys.count > 0 {
            let str = "\(url)" + "\(sort(filterParams))"+"time"
            return str.md5() + Config.yida_cache_mark
        } else {
            return (url+"time").md5() + Config.yida_cache_mark
        }
    }

    /// 参数排序生成字符串
    class func sort(_ parameters: [String: Any]?) -> String {
        var sortParams = ""
        if let params = parameters {
            let sortArr = params.keys.sorted { $0 < $1 }
            sortArr.forEach { str in
                if let value = params[str] {
                    sortParams = sortParams.appending("\(str)=\(value)")
                } else {
                    sortParams = sortParams.appending("\(str)=")
                }
            }
        }
        return sortParams
    }
    
    /** 清除key-value*/
    class func remove(_ key:String){
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: key)
        userDefaults.synchronize()
    }
    
    /** 清除userDefaults所有数据*/
    class func removeAll(){
        let userDefaults = UserDefaults.standard
        let dics = userDefaults.dictionaryRepresentation()
        for key in dics {
            if key.key.contains(Config.yida_cache_mark) {
                userDefaults.removeObject(forKey: key.key)
            }
        }
        userDefaults.synchronize()
    }
}


//
//  RequestManager.swift
//  MVP
//
//  Created by cjjc on 2022/8/29.
//

import Foundation
import SwiftyUserDefaults
import HandyJSON
import Kingfisher

class RequestManager{
    static let `default` = RequestManager()
    private var dataRequest: DataRequest?
    private var currentIsCache: Bool = false
    private var currentCachetime = 60*60*24
    private var cacheKey: String!
    private var cachetimeKey: String!
    private var urlSting : String = ""
    
    lazy var sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        let reachability = NetworkReachabilityManager()
        
        if (reachability?.isReachable)! {
            configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        }else{
            configuration.requestCachePolicy = .returnCacheDataElseLoad
        }
        return Alamofire.Session(configuration: configuration)
    }()
    
    // MARK: -  普通请求
    func request(_ url: String,
                 method: HTTPMethod = .post,
                 params: Parameters? = nil,
                 encoding: ParameterEncoding,
                 headers: HTTPHeaders? = nil) -> RequestManager {
        
        urlSting = url
        cacheKey = CacheManage.cacheKey(url, params)
        cachetimeKey = CacheManage.cacheTimeKey(url, params)
        
        pLog("==================接收到请求==================",
             "\(method.rawValue)url == \(url)",
             "params == \(params ?? ["":""])",
             "token  == \(Defaults.userInfo?.token ?? "")")
        
        dataRequest = sessionManager.request(url, method: method, parameters: params, encoding: encoding, headers: headers)
        
        return self
    }
    
    /// 是否缓存数据
    func cache(_ cache: Bool) -> RequestManager {
        self.currentIsCache = cache
        return self
    }
    /// 设置缓存时间
    func cacheTime(_ time: Int = 60*60*24) -> RequestManager{
        self.currentCachetime = time
        return self
    }
    
    ///获取缓存 无泛型
    func responseCacheJson(success:((_ response:JSON,_ data: BaseModel) -> Void)?,
                           fail:((_ error : Error?)->Void)?){
        parseCacheJson(isCache: currentIsCache, cacheTime: currentCachetime, cacheSuccess: success, fail: fail)
    }
    ///获取缓存 泛型
    func responseCacheJson<T:HandyJSON>(type:T.Type,
                                        success:((_ response:JSON,_ data: BaseModel) -> Void)?,
                                        fail:((_ error : Error?)->Void)?){
        parseCacheJson(isCache: currentIsCache, cacheTime: currentCachetime,type:type,cacheSuccess: success, fail: fail)
        
    }
    ///只网络请求 无泛型
    func responseJson(success:((_ response:JSON,_ data: BaseModel) -> Void)?,
                      fail:((_ error : Error?)->Void)?) {
        let cache = currentIsCache
        let cachetime = currentCachetime
        dataRequest?.validate().responseData(completionHandler: { [weak self] response in
            self?.parseJson(isCache: cache, cacheTime: cachetime,response: response, success: success, fail: fail)
        })
    }
    ///只网络请求 泛型
    func responseJson<T:HandyJSON>(type:T.Type,
                                   success:((_ response:JSON,_ data: BaseModel) -> Void)?,
                                   fail:((_ error : Error?)->Void)?) {
        let cache = currentIsCache
        let cachetime = currentCachetime
        dataRequest?.validate().responseData(completionHandler: { [weak self] response in
            self?.parseJson(isCache: cache, cacheTime: cachetime,type: type,response: response, success: success, fail: fail)
        })
    }
    
    ///获取缓存及网络请求  无泛型
    func responseCacheAndJson(cacheSuccess:((_ response:JSON,_ data: BaseModel) -> Void)?,
                              success:((_ response:JSON,_ data: BaseModel) -> Void)?,
                              fail:((_ error : Error?)->Void)?){
        let cache = currentIsCache
        let cachetime = currentCachetime
        
        parseCacheJson(isCache: cache, cacheTime: cachetime,cacheSuccess: cacheSuccess,fail: nil)
        
        dataRequest?.validate().responseData(completionHandler: { [weak self] response in
            self?.parseJson(isCache: cache, cacheTime: cachetime,response: response, success: success, fail: fail)
        })
    }
    
    ///获取缓存及网络请求  泛型
    func responseCacheAndJson<T:HandyJSON>(type:T.Type,
                                           cacheSuccess:((_ response:JSON,_ data: BaseModel) -> Void)?,
                                           success:((_ response:JSON,_ data: BaseModel) -> Void)?,
                                           fail:((_ error : Error?)->Void)?){
        
        let cache = currentIsCache
        let cachetime = currentCachetime
        
        self.parseCacheJson(isCache: cache, cacheTime: cachetime,type: type,cacheSuccess: cacheSuccess,fail: nil)
        
        dataRequest?.validate().responseData(completionHandler: { [weak self] response in
            self?.parseJson(isCache: cache, cacheTime: cachetime,type: type, response: response, success: success, fail: fail)
        })
    }
    
    //缓存数据
    private func cacheJson(isCache:Bool,
                           cacheTime:Int,
                           response: (AFDataResponse<Data>),
                           value:(Data)){
        if isCache == true {
            
            if let any = try? JSONSerialization.jsonObject(with: response.request?.httpBody ?? Data(), options: .allowFragments){
                
                let dict : Dictionary = any as! Dictionary<String, Any>
                
                cacheKey = CacheManage.cacheKey(response.request?.url?.absoluteString ?? "", dict)
                cachetimeKey = CacheManage.cacheTimeKey(response.request?.url?.absoluteString ?? "", dict)
            }else{
                cacheKey = CacheManage.cacheKey(response.request?.url?.absoluteString ?? "", nil)
                cachetimeKey = CacheManage.cacheTimeKey(response.request?.url?.absoluteString ?? "", nil)
            }
            let ud = UserDefaults.standard
            ud.set(value, forKey: cacheKey)
            ud.set(Date.init().timeStamp.int + cacheTime, forKey: cachetimeKey)
            
            ud.synchronize()
        }
    }
    ///缓存数据解析 无泛型
    private func parseCacheJson(isCache:Bool,
                                cacheTime:Int,
                                cacheSuccess:((_ response:JSON,_ data: BaseModel) -> Void)?,
                                fail:((_ error : Error?)->Void)?){
        
        let ud = UserDefaults.standard
        
        if (ud.value(forKey: cacheKey) != nil) {
            
            let time = ud.integer(forKey: cachetimeKey)
            //保存的时间戳小于当前时间戳 说明已过期
            if time < Date.init().timeStamp.int {
                ud.removeObject(forKey: cacheKey)
                if let handle = fail {
                    handle(NSError.init(domain: "缓存数据已过期", code: 100))
                }
            }else{
                let value = ud.value(forKey: cacheKey)
                
                ResponseDeal.dealSuccess(json: JSON(value as Any), url: urlSting, success: cacheSuccess)
            }
        }else{
            if let handle = fail {
                handle(NSError.init(domain: "无缓存数据", code: 100))
            }
        }
    }
    ///缓存数据解析 泛型
    private func parseCacheJson<T:HandyJSON>(isCache:Bool,
                                             cacheTime:Int,
                                             type:T.Type,
                                             cacheSuccess:((_ response:JSON,_ data: BaseModel) -> Void)?,
                                             fail:((_ error : Error?)->Void)?){
        let ud = UserDefaults.standard
        
        if (ud.value(forKey: cacheKey) != nil) {
            
            let time = ud.integer(forKey: cachetimeKey)
            //保存的时间戳小于当前时间戳 说明已过期
            if time < Date.init().timeStamp.int {
                ud.removeObject(forKey: cacheKey)
                if let handle = fail {
                    handle(NSError.init(domain: "缓存数据已过期", code: 100))
                }
            }else{
                let value = ud.value(forKey: cacheKey)
                
                ResponseDeal.dealSuccess(type: type, json: JSON(value as Any), url: self.urlSting, success: cacheSuccess)
            }
        }else{
            if let handle = fail {
                handle(NSError.init(domain: "无缓存数据", code: 100))
            }
        }
    }
    ///网络数据解析 无泛型
    private func parseJson(isCache:Bool,
                           cacheTime:Int,
                           response:AFDataResponse<Data>,
                           success:((_ response:JSON,_ data: BaseModel) -> Void)?,
                           fail:((_ error : Error?)->Void)?){
        ResponseDeal.dealJson(response: response)
        
        switch response.result{
            
        case .success(let value):
            
            cacheJson(isCache: isCache, cacheTime: cacheTime,response: response,value:value)
            
            ResponseDeal.dealSuccess(json: JSON(value),url: response.request?.url?.absoluteString ?? "", success: success)
            
        case .failure(let error):
            
            ResponseDeal.dealError(error: error, response: response, success: success, fail: fail)
        }
    }
    
    ///网络数据解析 泛型
    private func parseJson<T:HandyJSON>(isCache:Bool,
                                        cacheTime:Int,
                                        type:T.Type?,
                                        response:AFDataResponse<Data>,
                                        success:((_ response:JSON,_ data: BaseModel) -> Void)?,
                                        fail:((_ error : Error?)->Void)?){
        ResponseDeal.dealJson(response: response)
        
        switch response.result{
            
        case .success(let value):
            
            cacheJson(isCache: isCache, cacheTime: cacheTime,response: response,value:value)
            
            ResponseDeal.dealSuccess(type: type, json: JSON(value),url: response.request?.url?.absoluteString ?? "", success: success)
            
        case .failure(let error):
            
            ResponseDeal.dealError(error: error, response: response, success: success, fail: fail)
        }
    }
    
    // MARK: -  上传图片
    func uploadImage(_ url:String,
                     data: [Data],
                     params: [String: String]? = nil,
                     headers: HTTPHeaders? = nil,
                     success: ((_ value: Any) -> Void)?,
                     fail: ((_ error: Error) -> Void)?){
        pLog("==================接收到请求==================",
             "posturl == \(url)",
             "params == \(params ?? ["":""])",
             "token  == \(Defaults.userInfo?.token ?? "")")
        
        dataRequest = sessionManager.upload(multipartFormData: { multipartFormData in
            for i in 0..<data.count {
                let name : String = "file"
                multipartFormData.append(data[i], withName: name, fileName: ".png", mimeType: "image/png")
            }
            if let params = params {
                for (key, value) in params {
                    guard let data = value.data(using: .utf8) else { continue }
                    multipartFormData.append(data, withName: key)
                }
            }
        }, to: url, method: .post, headers: headers)
        .responseData { response in
            switch response.result {
            case .success(let value):
                if let handle = success {
                    handle(value)
                }
            case .failure(let error):
                
                if let handle = fail {
                    handle(error)
                }
            }
        }
    }
    
}

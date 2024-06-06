//
//  ResponseDeal.swift
//  MVP
//
//  Created by cjjc on 2022/8/31.
//

import Foundation

class ResponseDeal {
    // MARK: -  成功回调处理 有泛型
    class func dealSuccess<T:HandyJSON>(type:T.Type?,
                                  json:JSON,
                                  url:String,
                                  success:((_ response:JSON,_ data: BaseModel) -> Void)?){
        if let handle = success {
            var bean = BaseModel(code: "0", message: "接口请求有误",url: url, result: nil)
            
            if var base = BaseModel.deserialize(from: json.description) {
                base.url = url
                bean = base
            }
            
            if let model = T.deserialize(from: json["result"].description) {
                bean.model = model
            }
            
            if let list = Array<T>.deserialize(from: json["result"]["records"].description) {
                bean.list = list
            }
            
            handle(json,bean)
        }
    }
    
    // MARK: -  成功回调处理 无泛型
    class func dealSuccess(json:JSON,
                     url:String,
                     success:((_ response:JSON,_ data: BaseModel) -> Void)?){
        if let handle = success {
            
            var bean = BaseModel(code: "0", message: "接口请求有误",url: url, result: nil)
            
            if var base = BaseModel.deserialize(from: json.description) {
                base.url = url
                bean = base
            }
            handle(json,bean)
        }
    }
    
    // MARK: -   error处理
    class func dealError(error: (AFError),
                   response: AFDataResponse<Data>,
                   success:((_ response:JSON,_ data: BaseModel) -> Void)?,
                   fail:((_ error : Error?)->Void)?){
        
        if error.responseCode == 401 {
            let dic = ((String.init(data: response.data!, encoding: .utf8))?.dic)!
            MessageDrop.showDrop(body: dic["message"] as! String, type: .failure)
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                UIViewController.login()
            })
            
            if let handle = success {
                let json = JSON(dic)
                
                var bean = BaseModel(code: "0", message: "接口请求有误",url: response.request?.url?.absoluteString ?? "", result: nil)
                
                if var base = BaseModel.deserialize(from: json.description) {
                    base.url = response.request?.url?.absoluteString ?? ""//self.urlSting
                    bean = base
                }
                handle(json,bean)
            }
            
        }else{
            if error.responseCode == 666 {
                NotificationCenter.default.post(name: NSNotification.Name("version"), object: nil)
            }
            if let handle = fail {
                handle(error)
            }
        }
    }
    
    // MARK: -  json处理
    class func dealJson(response: AFDataResponse<Data>){
        
        switch response.result{
        case .success(_): break
           
        case .failure(_): break
           
        }
        
        netLog(response: response)
    }
    // MARK: -  打印提示
    class func netLog(response: AFDataResponse<Data>){

        switch response.result{
        case .success(let value):
            pLog("==================请求已完成==================",
                 "url == \(response.request?.url?.absoluteString ?? "") \(JSON(value))"
            )
        case .failure(let error):
            pLog("==================请求失败==================",
                 "url == \(response.request?.url?.absoluteString ?? "") \(error.localizedDescription )"
            )
        }
    }
}

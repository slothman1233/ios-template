//
//  Test.swift
//  MVP
//
//  Created by cjjc on 2022/8/29.
//

import Foundation
enum NetworkStatus {
    case unknown
    case notReachable
    case ethernetOrWiFi
    case wwan
}
class Net{
    fileprivate static let reachability = NetworkReachabilityManager()!
    class func request(_ url: String,
                       method: HTTPMethod = .post,
                       params: Parameters? = nil) -> RequestManager{
//        guard networkIsReachable() else { // 判断网络是否可用
//            if let handle = fail {
//                handle(NSError(domain: "没有网络", code: 0, userInfo: nil) )
//            }
//        }
        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        
        return RequestManager.default.request(url, method: method, params: params, encoding: encoding, headers: credential(par: getNeedSignStrFrom(dic: JSON(params ?? ["":""]))))
    }
    // MARK: -  上传图片
    class func uploadImage(_ url:String,
                           data: [Data],
                           params: [String: String]? = nil,
                           success: ((_ value: Any) -> Void)?,
                           fail: ((_ error: Error) -> Void)?){

        return RequestManager.default.uploadImage(url, data: data, params: params, headers: credential(par: getNeedSignStrFrom(dic: JSON(params ?? ["":""]))), success: success, fail: fail)
    }
    
    
    class func header(_ parameters: Parameters? = nil)->HTTPHeaders{
        let sortedKeys = (parameters?.keys)?.sorted()
        var str : String = ""
        if sortedKeys != nil {
            for i in sortedKeys! {
                let json = JSON(parameters?[i] as Any)
                str += json.stringValue
            }
        }
        var header = HTTPHeaders.init()
        let he =  HTTPHeader.init(name: "type11111", value: "ios222222")
        header.add(he)
        return header
    }
    class func getNeedSignStrFrom(dic:JSON)->String{
        var str : String = ""
        let sortedKeys = (dic.dictionary?.keys)?.sorted()
        if sortedKeys != nil {
            for i in sortedKeys! {
                if i == "userId" || i == "memberId" || i == "buyerId"{
                    
                }else{
                    let json = JSON(dic.dictionary?[i] as Any)
                    str += json.stringValue
                }
            }
        }
        
        return str.replacingOccurrences(of: "+", with: " ")
    }
    class func credential(par:String)->HTTPHeaders{
        
        var header = HTTPHeaders.init()
        
        let radom = Radom()
        let secret = "36335ee8-2bb8-4ecf-a6c1-19e06447926e"
        let time = Date.init().timeStamp
        
        var c = (time+radom.string+secret).md5()
        var e = ""
        var d = c.suffix(16).lowercased()
        
        if !par.isEmpty {
            e = String(par.md5().suffix(16))
            c = (time+radom.string+secret+e).md5()
            d = c.suffix(16).lowercased()
        }
        header.add(HTTPHeader.init(name: "timestamp", value: time))
        header.add(HTTPHeader.init(name: "once", value: radom.string))
        header.add(HTTPHeader.init(name: "signature", value: d))
        header.add(HTTPHeader.init(name: "Token", value:Defaults.userInfo?.token ?? ""))
        header.add(HTTPHeader.init(name: "version", value:Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String))
        header.add(HTTPHeader.init(name: "versionType", value:"iOS"))
        return header
    }
    
    // MARK: networkIsAvailable
    class func networkIsReachable() -> Bool {
        return reachability.isReachable
    }
    
    // MARK: networkReachabilityStatus
    class func networkReachabilityStatus() -> NetworkStatus {
        switch reachability.status {
        case .reachable(.ethernetOrWiFi):
            return NetworkStatus.ethernetOrWiFi
        case .reachable(.cellular):
            return NetworkStatus.wwan
        case .notReachable:
            return NetworkStatus.notReachable
        default:
            return NetworkStatus.unknown
        }
    }
    
    // MARK: monitoring
    class func networkReachability(handle: ((_ status: NetworkStatus) -> Void)?) {
        reachability.startListening { (status) in
            if let action = handle {
                switch status {
                case .notReachable:
                    action(NetworkStatus.notReachable)
                case .reachable(.ethernetOrWiFi):
                    action(NetworkStatus.ethernetOrWiFi)
                case .reachable(.cellular):
                    action(NetworkStatus.wwan)
                default:
                    action(NetworkStatus.unknown)
                }
            }
        }
    }
    
}

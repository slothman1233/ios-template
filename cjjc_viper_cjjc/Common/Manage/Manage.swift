//
//  Manage.swift
//  YiDa
//
//  Created by cjjc on 2022/8/31.
//

import Foundation

let UserManger = Manage.instance

enum CertifState : Int {
    case none = 0
    case auditing = 1
    case succeed = 2
    case fail = 3
}

class Manage {
    
    var userModel: UserInfo?
    
    static let instance = Manage.init()
    
    private init() {
        getModel()
    }
    
    func saveModel(_ model: UserInfo?) {
        userModel = model
    }
    
    func getModel() {
        userModel = Defaults.userInfo
    }
    
    func clear() {
        userModel = nil
    }
    
    var islogin: Bool {
        get {
            return Manage.instance.userModel?.token != nil
        }
    }
    
    var token: String {
        get {
            return Manage.instance.userModel?.token ?? ""
        }
    }
    
    func pushVerifyStatus(handle: ((_ status : CertifState) -> Void)?) {
        
        let status = Manage.instance.userModel?.verifyStatus ?? 0
        
        switch CertifState(rawValue: status) ?? .none {
            
            /// 没认证
        case .none:
            
            Alert.init(title: "实名认证", message: "去实名认证", style: .alert, actionTitles: ["取消","确定"]) { index, str in
                if index == 1 {
                    if let handle = handle {
                        handle(CertifState.none)
                    }
                }
            }.show()
            
            /// 已经提交
        case .auditing:
            
            Alert.init(title: "实名认证", message: "等待实名认证审核", style: .alert, actionTitles: ["取消","确定"]) { index, str in
                if index == 1 {
                    if let handle = handle {
                        handle(CertifState.auditing)
                    }
                }
            }.show()
            /// 成功
        case .succeed:
            
            if let handle = handle {
                handle(CertifState.succeed)
            }
            /// 失败
        case .fail:
            
            Alert.init(title: "实名认证", message: "实名认证失败, 重新提交资料", style: .alert, actionTitles: ["取消","确定"]) { index, str in
                if index == 1 {
                    if let handle = handle {
                        handle(CertifState.fail)
                    }
                }
            }.show()
        }
    }
   
}

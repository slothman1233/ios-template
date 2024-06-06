//
//  RouterType.swift
//  Mall
//
//  Created by cjjc on 2022/7/15.
//

import Foundation

enum PushType{
    case push
    case present
}
// MARK: -  路由相关
protocol RouterProtocol: AnyObject {
    //跳转新页面并传值
    func pushNewVC(currVC:Any?,positiveModel:CallBackModel? )
    
    //跳转新页面
    func pushNewVC(currVC:Any?)
    
    //返回
    func back(currVC:Any?)
}

class BaseRouter : RouterProtocol{
    
    func pushNewVC(currVC: Any?) {
        
    }
    
    func pushNewVC(currVC: Any?, positiveModel: CallBackModel? = nil) {
        
    }
  
    func back(currVC: Any?) {
        (currVC as? UIViewController)?.navigationController?.popViewController(animated: true)
        (currVC as? UIViewController)?.dismiss(animated: true, completion: nil)
    }
    
    required init() {}
}

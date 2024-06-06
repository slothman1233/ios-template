//
//  TextBannerInteractor.swift
//  YiDa
//
//  Created by cjjc on 2022/8/5.
//

import UIKit



class TextBannerInteractor: BaseInteractor,TextBannerInteractorProtocol {
    
    
    required init() {}
    
    func request(para: Parameters?,success:SuccessBlock,fail:FailBlcok) {
        
        SysPlatformNoticeRequest.getSysNotice(para: para) { model in
            
            var data = model
            
            if let handle = success {
                if let array = model.result as? [SysPlatformNoticeModel] {
                    if array.count > 3 {
                        data.result = array.compactMap { $0.title }.prefix(3)
                    }else{
                        data.result = array.compactMap { $0.title }
                    }
                    handle(data)
                }
            }
        } fail: { error in
            if let handle = fail {
                handle(error)
            }
        }

    }
}




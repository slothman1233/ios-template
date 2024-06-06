//
//  SysPlatformNoticeRequest.swift
//  YiDa
//
//  Created by cjjc on 2022/8/12.
//

import Foundation

struct SysPlatformNoticeRequest {
    static func getSysNotice(para: Parameters?,success:SuccessBlock,fail:FailBlcok){
        
        Net.request(Api.getSysPlatformNotice).responseJson(type: SysPlatformNoticeModel.self) { response, data in
            if let handle = success {
                handle(data)
            }
        } fail: { error in
            if let handle = fail {
                handle(error)
            }
        }

    }
}

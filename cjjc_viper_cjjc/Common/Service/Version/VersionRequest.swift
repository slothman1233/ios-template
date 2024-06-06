//
//  VersionRequest.swift
//  MVP
//
//  Created by cjjc on 2022/9/8.
//

import Foundation

struct VersionRequest {
    //更新
    static func getSysVersion(success:SuccessBlock,fail:FailBlcok){
        
        Net.request(Api.getSysVersion,method: .get).responseJson(type: VersionModel.self) { response, data in
            if let handle = success{
                handle(data)
            }
        } fail: { error in
            if let handle = fail {
                handle(error)
            }
        }
        
    }
}

//
//  PictureModel.swift
//  YiDa
//
//  Created by A1 on 2022/8/12.
//

import Foundation
///yd-api-member/sysUrlConfig/getRotationUrl


enum BannerType : Int {
    case home = 1
    case find = 2
    case rule = 4
}


struct PictureRequest {
    
    static func getRotationUrl(is type: BannerType, callback: SuccessBlock, fail: FailBlcok) {
        
        Net.request(Api.getRotationUrl,method: .get).responseJson(type: PictureModel.self) { response, data in
            if let handle = callback {
                handle(data)
            }
        } fail: { error in
            if let handle = fail {
                handle(error)
            }
        }

    }

}

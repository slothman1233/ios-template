//
//  HomeBannerInteractor.swift
//  YiDa
//
//  Created by cjjc on 2022/8/5.
//

import UIKit



class HomeBannerInteractor: BaseInteractor,HomeBannerInteractorProtocol {
    
    required init() {}
    
    func getBanner(is type: BannerType, callback: SuccessBlock, fail: FailBlcok) {
        PictureRequest.getRotationUrl(is: type, callback: callback, fail: fail)
    }
    
}




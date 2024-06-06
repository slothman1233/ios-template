//
//  HomeBannerProtocol.swift
//  YiDa
//
//  Created by cjjc on 2022/8/5.
//

import UIKit

///所有协议均继承自base
// MARK: -  页面相关协议
protocol HomeBannerViewProtocol:BaseViewProtocol {
    
    func updateImageArray(array: [String])
    
}


// MARK: -  操作器相关协议
protocol HomeBannerPresentProtocol:PresenterViewProtocol {
    
    func getBanner(is type: BannerType)
    
}

// MARK: -  网络相关协议
protocol HomeBannerInteractorProtocol:InteractorProtocol {
    
    func getBanner(is type: BannerType, callback: SuccessBlock, fail: FailBlcok)
    
}

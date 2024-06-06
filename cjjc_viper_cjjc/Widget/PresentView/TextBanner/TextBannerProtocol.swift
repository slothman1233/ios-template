//
//  TextBannerProtocol.swift
//  YiDa
//
//  Created by cjjc on 2022/8/5.
//

import UIKit

///所有协议均继承自base
// MARK: -  页面相关协议
protocol TextBannerViewProtocol:BaseViewProtocol {
    func updateGroup(titles:[String])
}


// MARK: -  操作器相关协议
protocol TextBannerPresentProtocol:PresenterViewProtocol {
    // 查看更多
    func moreClick()
    
    // 当前点击内容
    func itemClick(index:Int)
    
    
    func request()
}

protocol TextBannerDelegate:AnyObject{
    // 查看更多
    func moreClick()
    
    // 当前点击内容
    func itemClick(index:Int)
}

// MARK: -  网络相关协议
protocol TextBannerInteractorProtocol:InteractorProtocol {
    func request(para: Parameters?,success:SuccessBlock,fail:FailBlcok)
}

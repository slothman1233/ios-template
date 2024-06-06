//
//  InteractorType.swift
//  Mall
//
//  Created by cjjc on 2022/7/15.
//

import Foundation



/// Describes interactor component in a VIPER architecture.
protocol InteractorProtocol: AnyObject {
    //默认请求方法
    func loadData(para: Parameters?,success:SuccessBlock,fail:FailBlcok)
}

class BaseInteractor:InteractorProtocol{
    required init() {}
    //默认请求方法
    func loadData(para: Parameters?,success:SuccessBlock,fail:FailBlcok){}
}

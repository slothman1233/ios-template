//
//  UserProtocol.swift
//  MVP
//
//  Created by cjjc on 2022/9/8.
//

import UIKit

///所有协议均继承自base
// MARK: -  页面相关协议
protocol UserVCProtocol:BaseVCProtocol {
    
}

// MARK: -  路由相关协议
protocol UserRouterProtocol:RouterProtocol{
    
}

// MARK: -  操作器相关协议
protocol UserPresentProtocol:PresenterProtocol {
    
}

// MARK: -  网络相关协议
protocol UserInteractorProtocol:InteractorProtocol {
    
}

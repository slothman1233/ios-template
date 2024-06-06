//
//  HomeBannerRouter.swift
//  YiDa
//
//  Created by cjjc on 2022/8/25.
//

import Foundation
import UIKit
class HomeBannerRouter{
    
    /// 初始化banner 相关组件
    /// - Returns: p: present层<interactor层>    v:view层
    class func buildView()->(p:HomeBannerPresent<HomeBannerInteractor>,v:UIView){
        let p = HomeBannerPresent.init(i: HomeBannerInteractor.init())
        let v = HomeBannerView.init(present: p)
        
        p.vc = v
        
        return (p:p,v:v)
    }
}
